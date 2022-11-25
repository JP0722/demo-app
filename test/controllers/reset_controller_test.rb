require "test_helper"

class ResetControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get reset_show_url
    assert_response :success
  end

  test "should get update" do
    get reset_update_url
    assert_response :success
  end
end
