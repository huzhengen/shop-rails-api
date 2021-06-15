require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "index_success: should show users" do
    get api_v1_users_path, as: :json
    assert_response 200
  end
end
