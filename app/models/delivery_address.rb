class DeliveryAddress < ApplicationRecord

  belongs_to :customer

  validates :name, presence: { message: 'を入力してください。'}
  validates :post_code, presence: { message: 'を入力してください。'}
  validates :address, presence: { message: 'を入力してください。'}

end
