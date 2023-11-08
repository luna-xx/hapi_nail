require "test_helper"

class Customer::TagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_tag_index_url
    assert_response :success
  end
end
