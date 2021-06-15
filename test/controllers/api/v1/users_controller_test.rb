require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "index_success: should show users" do
    get api_v1_users_path, as: :json
    assert_response 200
  end

  test "show_success: should show one user" do
    get api_v1_user_path(@user), as: :json
    json_response = JSON.parse(self.response.body)
    assert_response 200
    assert_equal @user.email, json_response['data']['email']
  end
end
