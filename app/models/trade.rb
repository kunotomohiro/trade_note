class Trade < ApplicationRecord
  belongs_to :user
  belongs_to :trade_style
  belongs_to :trade_category
  has_one_attached :image, dependent: :destroy

  validates :result,     presence: true
  validates :pips,       presence: true
  validates :entry_time, presence: true
  validates :exit_time,  presence: true

  enum result: { "資産増": 0, "変化なし": 1,"資産減": 2 }

  include Trade::Searchable

  attr_accessor :current_user_id, :trade_category_id

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

  def user_trades
    Trade.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, trade_category_id)
  end

  def win_number_of_trades
    user_trades.where("result" => "資産増")
  end

  def total_win_rate
    return "0%" if win_number_of_trades.count === 0
    "#{(win_number_of_trades.count / user_trades.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate(trade_style_id)
    return "0%" if win_number_of_trades.count === 0
    trades = win_number_of_trades.where("trade_style_id" => trade_style_id).count
    "#{(trades / user_trades.count.to_f * 100).floor(1)}%"
  end

  def search_trades_in_year
    from  = Time.now.at_beginning_of_year
    to    = Time.now.at_end_of_year
    Trade.where(exit_time: from..to)
  end

  def user_trades_in_year
    search_trades_in_year.where("(user_id = ?) and (trade_category_id = ?)", current_user_id, trade_category_id)
  end

  def win_number_of_trades_in_year
    user_trades_in_year.where("result" => "資産増")
  end

  def total_win_rate_in_year
    return "0%" if win_number_of_trades_in_year.count === 0
    "#{(win_number_of_trades_in_year.count / user_trades_in_year.count.to_f * 100).floor(1)}%"
  end

  def trade_style_win_rate_in_year(trade_style_id)
    return "0%" if win_number_of_trades_in_year.count === 0
    trades = win_number_of_trades_in_year.where("trade_style_id" => trade_style_id).count
    "#{(trades / user_trades_in_year.count.to_f * 100).floor(1)}%"
  end

end
