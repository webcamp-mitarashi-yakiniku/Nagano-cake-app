FactoryBot.define do
  factory :genre, class: Genre do
    sequence(:name) { |n| "ジャンル_#{n}" }
    is_active       { true }
  end
end
