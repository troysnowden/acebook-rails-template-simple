class CommentsController < ApplicationController
  def new
    @user_id = session[:user_id]
    @post_id = params[:post_id]
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    redirect_to posts_url
  end

  def index

  end

  private

  def comment_params
    params.require(:comment).permit(:message, :user_id, :post_id)
  end
end
