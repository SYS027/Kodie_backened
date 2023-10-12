require "test_helper"

class Api::V1::Step1ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_step1_index_url
    assert_response :success
  end
end
