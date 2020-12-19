module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link "ログイン"
    fill_in "email__input", with: customer.email
    fill_in "password__input", with: customer.password
    click_button "ログイン"
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end