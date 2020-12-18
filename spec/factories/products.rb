FactoryBot.define do
  factory :product do
    association :genre
    image_id { "" }
    name { "ショートケーキ" }
    introduction { "このショートキーきは" }
    price { 1278 }
    on_sale_status { true }
  end
end
