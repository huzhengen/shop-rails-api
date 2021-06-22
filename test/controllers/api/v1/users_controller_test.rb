require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user2 = users(:two)
  end

  test "index_success: should show users" do
    get api_v1_users_path,
        headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
        as: :json
    assert_response 200
  end

  test "show_success: should show one user" do
    get api_v1_user_path(@user), as: :json
    json_response = JSON.parse(self.response.body)
    assert_response 200
    assert_equal @user.email, json_response['data']['email']
  end

  test "create_success: should create one user" do
    assert_difference('User.count', 1) do
      post api_v1_users_path,
           params: { user: { email: "test@test.com", password: "123456" } },
           as: :json
    end
    assert_response 201
  end

  test "update_success: should update one user" do
    patch api_v1_user_path(@user),
          params: { user: { email: '99@qq.com', password: '123456789' } },
          headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
          as: :json
    assert_response 202
  end

  test "destroy_success: should destroy one user" do
    assert_difference('User.count', -1) do
      delete api_v1_user_path(@user2),
             headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
             as: :json
    end
    assert_response 200
  end

  test "index_forbidden: should forbidden show users cause not admin" do
    get api_v1_users_path,
        headers: { Authorization: JsonWebToken.encode(user_id: @user2.id) },
        as: :json
    assert_response 403
  end

  test "update_forbidden: should forbidden update user cause not admin" do
    patch api_v1_user_path(@user),
          params: { user: { email: '99@qq.com', password: '123456789' } },
          headers: { Authorization: JsonWebToken.encode(user_id: @user2.id) },
          as: :json
    assert_response 403
  end

  test "destroy_forbidden: should forbidden destroy user cause not admin" do
    delete api_v1_user_path(@user),
           headers: { Authorization: JsonWebToken.encode(user_id: @user2.id) },
           as: :json
    assert_response 403
  end
end
