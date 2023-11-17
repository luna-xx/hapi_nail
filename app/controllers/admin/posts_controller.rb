class Admin::PostController < ApplicationController
  # 管理者のみアクセスできるようにする
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
  end
  
  def edit
  end

  def show
  end
  
  def create
  end
end
