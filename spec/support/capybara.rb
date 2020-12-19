# Capybaraにデフォルトでchromeを使ってテストするように設定する
Capybara.javascript_driver = :selenium_chrome
# ブラウザを開かずCLI上で実行するようにChromeのヘッドレスモードで実行する
# Capybara.javascript_driver = :selenium_chrome_headless