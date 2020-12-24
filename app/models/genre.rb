class Genre < ApplicationRecord

  has_many :products

  validates :name, presence: { message: 'を入力してください。'}

  # 有効・無効を日本語(string)で返す
  def is_active_JP
    if self.is_active then
      return "有効"
    else
      return "無効"
    end
  end
end
