FactoryBot.define do
  factory :customer do
    first_name { "一郎" }
    family_name { "田中" }
    first_name_kana { "イチロウ" }
    family_name_kana { "タナカ" }
    sequence(:email) { |n| "tanaka#{n}@gmail.com" }
    password { "tanakatanaka" }
    post_code { "8970008" }
    address { "東京都世田谷区駒沢3-1-1" }
    phone_number { "09087904563" }
  end
end
