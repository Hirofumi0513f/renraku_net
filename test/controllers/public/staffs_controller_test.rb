require "test_helper"

class Public::StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_staffs_index_url
    assert_response :success
  end

  test "should get show" do
    get public_staffs_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_staffs_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_staffs_update_url
    assert_response :success
  end

  test "should get search" do
    get public_staffs_search_url
    assert_response :success
  end
end
