class Customer::SearchesController < ApplicationController
  before_action :authenticate_user!
  # 検索機能
  def index
    @range = params[:range]
    # ifでuserとpostを条件分岐
    if @range == "ユーザー"
      @user = User.looks(params[:search], params[:word])
    elsif @range == "投稿"
      @posts = Post.looks(params[:search], params[:word])
    end
  end
  # def keyword_search
  #   perform_search(:keyword_search)
  # end
  
  # def tag_search
  #   perform_search(:tag_search)
  # end
  
  # private
  
  # def perform_search(view)
  #   @keyword = params[:keyword]
  #   @tag = params[:tag]

  #   if @keyword.present? || @tag.present?
  #     @posts = Post.search(@keyword, @tag)
  #   else
  #     @posts = []
  #   end

  #   render view
  # end
  
  
end
