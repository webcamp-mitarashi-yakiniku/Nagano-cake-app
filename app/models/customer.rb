class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :delivery_addresses, dependent: :destroy
  has_many :cart_products, dependent: :destroy

  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true

  # Emailの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: "正しいフォーマットを入力してください。" },
            uniqueness: { message: "このメールアドレスはすでに登録されています。" }
  validates :post_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  def full_name
    self.family_name + self.first_name
  end

  def Customer.search(search)
     Customer.where(["family_name LIKE? OR first_name LIKE?", "%#{search}%", "%#{search}%"])
  end
end
