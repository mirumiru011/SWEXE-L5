require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get likes_create_url
    assert_response :success
  end

  test "should get destro" do
    get likes_destro_url
    assert_response :success
  end
end
