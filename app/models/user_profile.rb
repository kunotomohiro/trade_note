class UserProfile < ApplicationRecord
  has_one_attached :avatar, dependent: :destroy
  belongs_to :user

  def base64upload(file)

    return if file.blank?
    prefix = file[/(image|application)(\/.*)(?=\;)/]
    type = prefix.sub(/(image|application)(\/)/, '')
    data = Base64.decode64(file.sub(/data:#{prefix};base64,/, ''))
    filename = "#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}.#{type}"
    File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
      f.write(data)
    end
    avatar.detach if avatar.attached?
    avatar.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
    
  end
  
end
