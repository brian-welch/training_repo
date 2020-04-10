require 'test_helper'

class UserWeightsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_weights_show_url
    assert_response :success
  end

  test "should get new" do
    get user_weights_new_url
    assert_response :success
  end

end
