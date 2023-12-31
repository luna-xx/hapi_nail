class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @coments = Comment.all
    @users = User.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path
  end
end
