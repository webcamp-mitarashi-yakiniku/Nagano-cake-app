class CartProduct < ApplicationRecord

  belongs_to :customer
  belongs_to :product

  validates :product_quantity, presence: { message: 'を選択してください。' }

end
