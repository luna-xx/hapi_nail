class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_users_path(user)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :furigana_name, :nick_name, :sex, :email, :top_image, :introduction, :is_active)
    .tap { |whitelisted| whitelisted[:is_active] = (params[:user][:is_active] == 'true') }
  end
end
