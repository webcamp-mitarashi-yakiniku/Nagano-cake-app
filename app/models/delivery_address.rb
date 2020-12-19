class DeliveryAddress < ApplicationRecord

  belongs_to :customer

  validates :name, presence: true
  validates :post_code, presence: true
  validates :address, presence: true

end
