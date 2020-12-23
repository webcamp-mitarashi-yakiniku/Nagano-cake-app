class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :delivery_addresses, dependent: :destroy
  has_many :cart_products, dependent: :destroy

  validates :family_name, presence: { message: 'を入力してください。'}
  validates :first_name, presence: { message: 'を入力してください。'}
  validates :family_name_kana, presence: { message: 'を入力してください。'}
  validates :first_name_kana, presence: { message: 'を入力してください。'}

  # Emailの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: "は正しいフォーマットを入力してください。" },
            uniqueness: { message: "この%{attribute}はすでに登録されています。" }
  validates :post_code, presence: { message: 'を入力してください。'}
  validates :address, presence: { message: 'を入力してください。'}
  validates :phone_number, presence: { message: 'を入力してください。'}

  def full_name
    self.family_name + self.first_name
  end

  def Customer.search(search)
    Customer.where(["family_name LIKE? OR first_name LIKE?", "%#{search}%", "%#{search}%"])
  end

  def active_for_authentication?
    super && (self.is_active == true)
  end
end
