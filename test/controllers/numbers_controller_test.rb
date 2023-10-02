require "test_helper"

class NumbersControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get numbers_generate_url
    assert_response :success
  end

  test "should get download" do
    get numbers_download_url
    assert_response :success
  end
end
