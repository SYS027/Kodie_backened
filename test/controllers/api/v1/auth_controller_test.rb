require "test_helper"

class Api::V1::AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get Signup" do
    get api_v1_auth_Signup_url
    assert_response :success
  end

  test "should get index" do
    get api_v1_auth_index_url
    assert_response :success
  end
end
