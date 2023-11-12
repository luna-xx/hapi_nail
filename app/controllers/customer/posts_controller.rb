class Customer::PostController < ApplicationController

  def new
    # 空のインスタンス生成
    @post = Post.new
  end

  def index
    # 全てのレコードを取得
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  # 投稿データの保存
  def create
    #データを新規登録するためのインスタンス生成
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    #データをデータベースに保存するためのsaveメソッド実行
    @post.save
    #マイページ画面へリダイレクト
    redirect_to user_my_page_path
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to '/posts'
  end

  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :text, :image, :tag_id)
  end
end
