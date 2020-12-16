class Product < ApplicationRecord

  has_many :cart_products
  has_many :order_products
  belongs_to :genre

  attachment :image
end
