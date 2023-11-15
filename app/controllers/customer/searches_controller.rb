class Customer::SearchesController < ApplicationController
  
  def keyword_search
    perform_search(:keyword_search)
  end
  
  def tag_search
    perform_search(:tag_search)
  end
  
  private
  
  def perform_search(view)
    @keyword = params[:keyword]
    @tag = params[:tag]

    if @keyword.present? || @tag.present?
      @posts = Post.search(@keyword, @tag)
    else
      @posts = []
    end

    render view
  end
end
