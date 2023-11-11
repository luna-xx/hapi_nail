class Customer::PostController < ApplicationController

  def new
    # 空のインスタンス生成
    @post = Post.new
  end

  def edit
  end

  def show
  end

  def create
    #データを新規登録するためのインスタンス生成
    @post = Post.new(post_params)
    #データをデータベースに保存するためのsaveメソッド実行
    @post.save
    #マイページ画面へリダイレクト
    redirect_to user_my_page_path
  end

  def update
  end

  def destroy

  end

  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :text, :image, :tag_id)
  end
end
