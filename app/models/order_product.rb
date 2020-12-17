class OrderProduct < ApplicationRecord

  belongs_to :order
  belongs_to :product

  # 空でないかつ整数のみ許容
  validates :price, presence: true, numericality: { only_integer: true }
  # 空でないかつ整数のみ許容
  validates :product_quantity, presence: true, numericality: { only_integer: true }
  # 0 ~ 3の整数のみ許容
  validates :work_status, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  def subtotal
    self.price * self.product_quantity
  end
end
