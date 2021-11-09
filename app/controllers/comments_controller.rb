class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    redirect_to posts_url
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end
end
