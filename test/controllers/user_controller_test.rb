require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_update_url
    assert_response :success
  end

  test "should get quit" do
    get user_quit_url
    assert_response :success
  end

  test "should get withdraw" do
    get user_withdraw_url
    assert_response :success
  end
end
