class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one  :user_profile, dependent: :destroy
  has_many :trades, dependent: :destroy

  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[A-Za-z\d]{8,100}\z/
end
