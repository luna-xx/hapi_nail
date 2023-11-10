class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find_by(params[:id])
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def quit
  end

  def withdraw
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :furogana_name, :sex, :nick_name,:introduction, :top_image, :email, :active)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    # ゲストユーザーかどうかの判別
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
end
