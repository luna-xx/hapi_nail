class Customer::PostController < ApplicationController

  def new
    # 空のインスタンス生成
    @post = Post.new
  end

  def index
    # 全てのレコードを取得
    @posts = Post.all
    @tag_list = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @tag_list = @post.tags.pluck(:name).join(',')
    @posttags = @post.tags
  end

  # 投稿データの保存
  def create
    #データを新規登録するためのインスタンス生成
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.tag_list = params[:post][:tag_list][:name].split(',')
    #データをデータベースに保存するためのsaveメソッド実行
    if @post.save
      @post.save_tags(tag_list)
      #マイページ画面へリダイレクト
      redirect_to post_path, notice: '投稿完了'
    else
      render :new
    end
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
  
  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @post = @tag.post
  end

  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :text, :image, :tag_id, :comment)
  end
end
