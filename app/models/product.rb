class Product < ApplicationRecord

  has_many :cart_products
  has_many :order_products
  belongs_to :genre

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  validates :genre_id, presence: true

  # 空でないかつ整数のみ許容
  validates :price, presence: true, numericality: { only_integer: true }
  # true/false のみ許容
  validates :on_sale_status, inclusion: {in: [true, false]}

end
