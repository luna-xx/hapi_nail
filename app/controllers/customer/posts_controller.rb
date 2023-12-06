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

    # 画像の存在チェック
    unless params[:post][:image]
      @post.errors.add(:image, "画像を選択してください")
      render :new
      return
    end
    
    if @post.save
      # フラッシュメッセージ
       flash[:notice] = "投稿完了しました"
      #マイページ画面へリダイレクト
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿失敗しました"
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

  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
end
