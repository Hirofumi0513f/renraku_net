require "test_helper"

class Admin::StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_staffs_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_staffs_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_staffs_edit_url
    assert_response :success
  end

  test "should get search" do
    get admin_staffs_search_url
    assert_response :success
  end
end
