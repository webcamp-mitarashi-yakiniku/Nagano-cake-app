FactoryBot.define do
  factory :customer1, class: Customer do
    family_name       { "竈門" }
    first_name        { "炭治郎" }
    family_name_kana  { "カマド" }
    first_name_kana   { "タンジロウ" }
    sequence(:email)  { |n| "kamado@tanjirou#{n}.com" }
    password          { "kamadotanjirou" }
    post_code         { "1001000" }
    address           { "東京都多摩市1-1" }
    phone_number      { "11111111111" }
    is_active         { true }
  end
end
