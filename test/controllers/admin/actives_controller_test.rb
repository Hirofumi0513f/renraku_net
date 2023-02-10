require "test_helper"

class Admin::ActivesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_actives_update_url
    assert_response :success
  end
end
