class UsersController < ApplicationController
  
  def show
    @user = User.find_by(params[:id])
  end
  
  def new
    @user = User.new
  end

  def edit
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
  end

  def quit
  end

  def withdraw
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :furogana_name, :sex, :nick_name, :top_image, :email, :active)
    
  end
end
