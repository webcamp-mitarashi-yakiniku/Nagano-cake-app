FactoryBot.define do
  factory :product1, class: Product do
    image           { File.open('./app/assets/images/sample_cake.png', ?r) }
    name            { "ロールケーキ" }
    introduction    { "おいしい" }
    price           { 100 }
    on_sale_status  { true }
    association :genre
  end
end
