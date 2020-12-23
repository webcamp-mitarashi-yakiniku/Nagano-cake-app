class Product < ApplicationRecord

  has_many :cart_products
  has_many :order_products
  belongs_to :genre

  attachment :image

  validates :name, presence: { message: 'を入力してください。'}
  validates :introduction, presence: { message: 'を入力してください。'}
  validates :image, presence: { message: 'を選択してください。'}

  # 空でないかつ整数のみ許容
  validates :price, presence: true, numericality: { only_integer: true, message: 'は数字を入力してください。' }
  # true/false のみ許容
  validates :on_sale_status, inclusion: {in: [true, false], message: 'を選択してください。' }

  def Product.search(search)
    Product.where(['name LIKE?', "%#{search}%"])
  end

end
