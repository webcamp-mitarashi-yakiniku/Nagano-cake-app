require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get locate" do
    get search_locate_url
    assert_response :success
  end

end
