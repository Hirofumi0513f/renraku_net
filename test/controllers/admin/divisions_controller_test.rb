require "test_helper"

class Admin::DivisionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_divisions_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_divisions_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_divisions_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_divisions_update_url
    assert_response :success
  end
end
