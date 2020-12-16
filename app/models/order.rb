class Order < ApplicationRecord
  # attr_accessor :order_billing_amount

  has_many :order_products
  belongs_to :customer

  validates :name, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  # 空でないかつ整数のみ許容
  validates :account, presence: true, numericality: { only_integer: true }
  # 空でないかつ整数のみ許容
  validates :shipping, presence: true, numericality: { only_integer: true }
  # 0, 1のみ許容
  validates :payment_method, presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  # 0 ~ 4の整数のみ許容
  validates :order_status,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 4 }

  def amount
    order_product_amount = 0
    # 各商品の注文個数をカウントする
    self.order_products.each do |order_product|
      order_product_amount += order_product.product_quantity
    end
    order_product_amount
  end

  def display_work_status
    # work_statusに応じて表示を分ける
    case self.order_status
    when 0
      "着手不可"
    when 1
      "製作待ち"
    when 2
      "制作中"
    when 3
      "製作完了"
    else
      "着手不可"
    end
  end

  def total_billing
    # 注文商品の小計を合計することで1つの注文における合計金額を算出する
    order_billing_amount = 0
    self.order_products.each do |order_product|
      order_billing_amount += order_product.subtotal
    end
    order_billing_amount
  end

  def total_billing_included_shipping
    # 合計金額に送料を含めた金額を算出する
    self.total_billing + self.shipping
  end
end

