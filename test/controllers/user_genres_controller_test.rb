require "test_helper"

class UserGenresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_genres_new_url
    assert_response :success
  end
end
