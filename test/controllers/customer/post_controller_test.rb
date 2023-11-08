require "test_helper"

class Customer::PostControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get customer_post_edit_url
    assert_response :success
  end

  test "should get show" do
    get customer_post_show_url
    assert_response :success
  end
end
