class Admin::PostController < ApplicationController
  
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
