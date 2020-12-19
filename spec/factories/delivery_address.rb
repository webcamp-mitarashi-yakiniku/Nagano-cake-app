FactoryBot.define do
  factory :delivery_address do
    association :customer
    name { "田中様" }
    post_code { "9087654" }
    address { "東京都足立区" }

    # 無効になっている
    trait :invalid do
      name { nil }
    end
  end
end