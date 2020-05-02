class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :trade_style
  belongs_to :trade_category
  has_one_attached :image

  enum result: { "資産増": 0, "変化なし": 1,"資産減": 2 }

  include Trade::Searchable

  attr_accessor :current_user_id

  def base64upload(file)

    return if file.blank?
    prefix = file[/(image|application)(\/.*)(?=\;)/]
    type = prefix.sub(/(image|application)(\/)/, '')
    data = Base64.decode64(file.sub(/data:#{prefix};base64,/, ''))
    filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}.#{type}"
    File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
      f.write(data)
    end
    image.detach if image.attached?
    image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
    
  end

  def search_user_fx_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 1)
  end

  def search_user_stock_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 2)
  end

  def search_user_virtual_currency_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, 3)
  end

  def win_number_of_fx_trades
    search_user_fx_trades.where("result" => "資産増")
  end

  def win_number_of_stock_trades
    search_user_stock_trades.where("result" => "資産増")
  end

  def win_number_of_virtual_currency_trades
    search_user_virtual_currency_trades.where("result" => "資産増")
  end

  def fx_win_rate
    return "0%" if win_number_of_fx_trades.count === 0
    "#{(win_number_of_fx_trades.count / search_user_fx_trades.count.to_f * 100).floor(1)}%"
  end

  def stock_win_rate
    return "0%" if win_number_of_stock_trades.count === 0
    "#{(win_number_of_stock_trades.count / search_user_stock_trades.count.to_f * 100).floor(1)}%"
  end

  def virtual_currency_win_rate
    return "0%" if win_number_of_virtual_currency_trades.count === 0
    "#{(win_number_of_virtual_currency_trades.count / search_user_virtual_currency_trades.count.to_f * 100).floor(1)}%"
  end

end
