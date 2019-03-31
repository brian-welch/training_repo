require 'test_helper'

class SessionSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get session_sets_index_url
    assert_response :success
  end

  test "should get new" do
    get session_sets_new_url
    assert_response :success
  end

  test "should get update" do
    get session_sets_update_url
    assert_response :success
  end

end
