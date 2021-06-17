class Api::V1::UsersController < ApplicationController
  before_action :set_per_page, only: [:index]
  before_action :set_page, only: [:index]
  before_action :set_user, only: [:show, :update, :destroy]
  # https://stackoverflow.com/questions/30632639/password-cant-be-blank-in-rails-using-has-secure-password
  wrap_parameters :user, include: [:email, :password]

  def index
    @users = User.offset(@page).limit(@per_page)
    render json: { error_code: 0, data: @users, message: 'ok' }, status: 200
  end

  def show
    render json: { error_code: 0, data: @user, message: 'ok' }, status: 200
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { error_code: 0, data: @user, message: 'ok' }, status: 201
    else
      render json: { error_code: 500, message: @user.errors }, status: 201
    end
  end

  def update
    if @user.update(user_params)
      render json: { error_code: 0, data: @user, message: 'ok' }, status: 202
    else
      render json: { error_code: 500, message: @user.errors }, status: 202
    end
  end

  def destroy
    @user.destroy
    render json: { error_code: 0, message: 'ok' }, status: 204
  end

  private

  def _to_i(page, default_no = 1)
    page && page.to_i > 0 ? page.to_i : default_no.to_i
  end

  def set_page
    @page = _to_i(params[:page], 1)
    @page = set_per_page * (@page - 1)
  end

  def set_per_page
    @per_page = _to_i(params[:per_page], 10)
  end

  def set_user
    @user = User.find_by_id params[:id].to_i
    @user = @user || {}
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
