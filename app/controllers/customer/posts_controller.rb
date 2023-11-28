class Customer::PostsController < ApplicationController
  before_action :authenticate_user!

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
    @user = @post.user
    @comment = Comment.new
    @tag_list = @post.tags.pluck(:name).join(',')
    @posttags = @post.tags
  end

  # 投稿データの保存
  def create
    #データを新規登録するためのインスタンス生成
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    # 画像の処理
    #@post.image = params[:post][:image]
    
    # 画像の存在チェック
    
    unless params[:post][:image]
      @post.errors.add(:image, "画像を選択してください")
      render :new
      return
    end
    
    #データをデータベースに保存するためのsaveメソッド実行

    if @post.save
      # タグの保存
      # @post.tag_list = params[:post][:tag_list] if params[:post][:tag_list]
      # @post.save
      #マイページ画面へリダイレクト
      redirect_to post_path(@post), notice: '投稿完了'
    else
      @post.errors.add(:image, "画像を選択してください")
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
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
    params.require(:post).permit(:title, :text, :image)
  end
end
