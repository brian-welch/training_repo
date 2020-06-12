require 'test_helper'

class SessionCardioBoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get session_cardio_bout_index_url
    assert_response :success
  end

  test "should get new" do
    get session_cardio_bout_new_url
    assert_response :success
  end

  test "should get create" do
    get session_cardio_bout_create_url
    assert_response :success
  end

end
