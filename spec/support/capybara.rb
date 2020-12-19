# Capybaraにデフォルトでchromeを使ってテストするように設定する
Capybara.javascript_driver = :selenium_chrome
# ブラウザを開かずCLI上で実行するようにChromeのヘッドレスモードで実行する
# Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: system, js: true) do
    driven_by :selenium_chrome_headless
  end
end