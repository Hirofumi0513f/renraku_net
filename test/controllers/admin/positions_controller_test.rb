require "test_helper"

class Admin::PositionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_positions_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_positions_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_positions_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_positions_update_url
    assert_response :success
  end
end
