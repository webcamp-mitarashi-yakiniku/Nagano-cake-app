# NaganoCake

## アプリケーションの概要
仮想の洋菓子店（ながのCAKE）の商品を通販するためのECサイトです。<br>
ユーザは会員登録すると商品を注文できるようになります。<br>
店舗側はユーザ情報の閲覧や商品の追加、受注後の制作フロー管理などができます。<br>

## 制作背景
DMM WEB CAMP ２ヶ月目後半に行われたチーム開発のカリキュラムで作成しました。<br>
スクールから要件定義書と画面遷移図があたえられるので、<br>
それをもとにチームで設計、実装、テスト、デプロイを実施しました。<br>

![トップページ](https://user-images.githubusercontent.com/49280097/102960762-fadfa780-4525-11eb-9829-c8cdd1b355fb.png)

## URL
http://nagano-cake.site/<br>
※サーバ代節約のため、リンク切れの可能性があります。<br>
  ご承知おきください。<br>

## 使用技術
### フロントエンド
- HTML
- CSS
- Bootstrap
- kaminari
- jQuery
### バックエンド
- Ruby 2.6.3
- Ruby on Rails 5.2.4
### サーバ
- Nginx
- Puma
- AWS (VPC,EC2,RDS)

### テスト/リファクタリング
- Rspec
- RuboCop

## AWS構成図
![AWS構成図](https://user-images.githubusercontent.com/49280097/103065861-f9cc7a00-45fa-11eb-83c0-f100196a65ec.png)

## 機能一覧
### ユーザ側
- 新規登録
- ログイン・ログアウト
- 商品一覧、詳細表示
- カートへの商品追加、購入
- ユーザ情報編集
- 商品配送先の追加、編集
- 自分の注文履歴一覧、詳細の閲覧
- ジャンルから商品を検索
### 管理者側
- ログイン・ログアウト
- 全ユーザの注文履歴一覧、詳細の閲覧
- ユーザ一覧、詳細の閲覧
- 商品一覧、詳細表示
- 商品ジャンル追加、編集
- 商品追加、編集
- ユーザ名や商品名での検索

## ER図
![ER図-ナガノCAKE](https://user-images.githubusercontent.com/49280097/102967615-ab08dc80-4535-11eb-9c82-77a3a68ec1f9.png)

## 制作メンバー
- [yuta_nkn](https://github.com/yuta252)
- [wkn816](https://github.com/wkn816)
- [Taketo Yamori](https://github.com/taketoyamori)
- [sf-12](https://github.com/sf-12)
