FactoryBot.define do
  factory :admin1, class: Admin do
    sequence(:email)  { |n| "agatuma@zenitu#{n}.com" }
    password          { "agatumazenitu" }
  end
end
