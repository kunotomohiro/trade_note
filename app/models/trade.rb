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

end
