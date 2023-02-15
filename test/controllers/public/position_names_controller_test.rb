require "test_helper"

class Public::PositionNamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_position_names_index_url
    assert_response :success
  end

  test "should get create" do
    get public_position_names_create_url
    assert_response :success
  end

  test "should get edit" do
    get public_position_names_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_position_names_update_url
    assert_response :success
  end
end
