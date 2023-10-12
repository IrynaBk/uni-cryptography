require "test_helper"

class Md5HashControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get md5_hash_generate_url
    assert_response :success
  end

  test "should get download" do
    get md5_hash_download_url
    assert_response :success
  end
end
