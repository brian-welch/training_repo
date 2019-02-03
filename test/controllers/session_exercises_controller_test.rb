require 'test_helper'

class SessionExercisesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get session_exercises_index_url
    assert_response :success
  end

  test "should get new" do
    get session_exercises_new_url
    assert_response :success
  end

  test "should get update" do
    get session_exercises_update_url
    assert_response :success
  end

end
