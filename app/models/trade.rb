class Trade < ApplicationRecord
  belogs_to :user
  has_many  :trade_styles
  has_many  :trade_categories
  has_many_attached :images
end
