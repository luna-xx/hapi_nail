class Admin::PostController < ApplicationController
  # 管理者のみアクセスできるようにする
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
    @tag_list = Tag.all
  end
  
  def edit
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @tag_list = @post.tags.pluck(:name).join(',')
    @posttags = @post.tags
  end
  
  def create
  end
  
  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post)
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :text, :image, :tag_id, :comment)
  end
end
