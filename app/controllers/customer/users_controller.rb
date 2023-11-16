class Customer::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = User.find_by(params[:id])
    @post = @user.posts
  end
  
  def new
    @user = User.new
  end
  
  # 編集画面
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
    @user.top_image.attach(params[:user][:top_image]) if params[:user][:top_image]
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  # 退会確認画面
  def quit
    # ユーザー情報を見つける
    @user = User.find(params[:id])
  end
  
  # 退会画面
  def withdraw
    # ログインしているユーザー情報を@userに格納
    @user =User.find(current_user.id)
    # 登録情報をInvalidに変更
    @user.update(is_active: "Invalid")
    # sessionIDをリセット
    reset_session
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :furogana_name, :sex, :nick_name,:introduction, :top_image, :email, :active)
  end
  # ゲストユーザー
  def ensure_guest_user
    @user = User.find(params[:id])
    # ゲストユーザーかどうかの判別
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end
end
