# メインのサンプル顧客を作成
Customer.create!(family_name: "田中", first_name: "一郎", family_name_kana: "タナカ", first_name_kana: "イチロウ",
                email: "tanaka.ichiro@gmail.com", password: "tanakatanaka", post_code: "1460092",
                address: "東京都渋谷区代々木1-1-1", phone_number: "09056334564", is_active: true)

# 他の顧客を作成
30.times do |n|
  Customer.create!(family_name: "#{n + 1}竈門", first_name: "#{n + 1}炭次郎", family_name_kana: "#{n + 1}カマド", first_name_kana: "#{n + 1}タンジロ",
    email: "kamado#{n + 1}@gmail.com", password: "kamadotanhiro", post_code: "1460092",
    address: "東京都世田谷区駒沢3-7-7", phone_number: "09077777777", is_active: true)
end

# 管理者を1名作成
Admin.create!(email: "test@gmail.com", password: "testtest")


# ジャンルを作成
Genre.create!(name: "ホールケーキ", is_active: true)
Genre.create!(name: "マドレーヌ", is_active: true)
Genre.create!(name: "モンブラン", is_active: true)
Genre.create!(name: "ロールケーキ", is_active: true)
Genre.create!(name: "ティラミス", is_active: true)

# 各ジャンルごとの商品を登録
5.times do |n|
  Product.create!(
    genre_id: 1,
    image: File.open('./app/assets/images/sample_cake.png', ?r),
    name: "#{n + 1}_ホールケーキ",
    introduction: "贅沢にイチゴをたくさんトッピング。クリスマスプレゼントにいかがでしょうか",
    price: 2980,
    on_sale_status: true
  )
end

5.times do |n|
  Product.create!(
    genre_id: 2,
    image: File.open('./app/assets/images/sample_madrenu.png', ?r),
    name: "#{n + 1}_マドレーヌ",
    introduction: "質素なお菓子、マドレーヌ。無塩バター、バターと同量の小麦粉、卵、砂糖、ベーキングパウダー、好みによりアーモンドパウダー、香料（バニラエッセンスなど）やブランデーを入れて良く混ぜ合わせオーブンで焼き上げる。あらかじめバターを塗って粉を振った貝殻型の焼き型の上に生地を載せて焼くことが多い",
    price: 1200,
    on_sale_status: true
  )
end

5.times do |n|
  Product.create!(
    genre_id: 3,
    image: File.open('./app/assets/images/sample_monbran.png', ?r),
    name: "#{n + 1}_モンブラン",
    introduction: "モンブランとは、クリなどを原料とするクリームを生地の上面に絞りかけたケーキである。山の形に似せて作ったことからこう呼ばれる。",
    price: 1800,
    on_sale_status: true
  )
end

5.times do |n|
  Product.create!(
    genre_id: 4,
    image: File.open('./app/assets/images/sample_rollcake.png', ?r),
    name: "#{n + 1}_ロールケーキ",
    introduction: "薄い長方形に焼いたスポンジケーキに、ジャムやクリーム類（ホイップクリーム、バタークリーム、カスタードクリームなど）、細かく切ったり甘露煮（グラッセ）にした果物などを載せ、渦巻き状に巻いたものである。",
    price: 1450,
    on_sale_status: true
  )
end

5.times do |n|
  Product.create!(
    genre_id: 5,
    image: File.open('./app/assets/images/sample_tiramisu.png', ?r),
    name: "#{n + 1}_ティラミス",
    introduction: "ティラミスは、北イタリア生まれのデザートの一種。語源の Tirami su! はイタリア語で「私を引っ張りあげて、また転じて「私を元気付けて」に由来する",
    price: 5600,
    on_sale_status: true
  )
end

# カートに商品を登録
5.times do |n|
  CartProduct.create!(
    product_id: (n + 1) * 4 + 1,
    customer_id: 1,
    product_quantity: 2
  )
end

# 配送先アドレスを登録
5.times do |n|
  DeliveryAddress.create!(
    customer_id: 1,
    name: "#{n}_田中三郎",
    post_code: "7890002",
    address: "福岡県博多市天神5-6"
  )
end

# メイン顧客の注文
Order.create!(
  customer_id: 1,
  name: "1番目顧客の宛先",
  post_code: "1090082",
  address: "福岡県博多市天神5-6",
  account: 5690,
  shipping: 800,
  payment_method: 0,
  order_status: 0
)

# メイン顧客の注文
3.times do |n|
  OrderProduct.create!(
    product_id: (n + 1) * 5,
    order_id: 1,
    price: 1900,
    product_quantity: 3,
    work_status: 0
  )
end


# 注文内容を登録
10.times do |n|
  Order.create!(
    customer_id: (n + 1) * 2,
    name: "#{(n + 1) * 2}番目顧客の宛先",
    post_code: "1090082",
    address: "新潟県南魚沼市6-7-7",
    account: 3980,
    shipping: 800,
    payment_method: 1,
    order_status: 0
  )

  2.times do |m|
    OrderProduct.create!(
      product_id: (m + 1) * 7,
      order_id: n + 2,
      price: 2500,
      product_quantity: 2,
      work_status: 0
    )
  end
end

