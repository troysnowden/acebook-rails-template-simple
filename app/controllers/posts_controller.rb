class PostsController < ApplicationController
  def new
    @user_id = session[:user_id]
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to posts_url
  end

  def index
    @posts_with_username = []
    @comment = Comment.new
    @like = Like.new
    @user_id = session[:user_id]
    
    Post.all.each do |post| 
      post_likes = 0
      Like.where(post_id: post[:id]).each do |like| 
        post_likes +=1
      end 

      post_comments = []
      post_comments_raw = Comment.where(post_id: post[:id]).each do |comment| 
        post_comments << {
          :id => comment.id,
          :message => comment.comment,
          :created_at => comment.created_at,
          :user_id => comment.user_id,
          :post_id => comment.post_id,
          :author_name => User.find_by(id: comment.user_id).full_name,
          :formatted_time => comment.created_at.strftime("on %d/%m/%Y at %k:%M"),
        }
      end

      @posts_with_username << {
        :id => post.id,
        :message => post.message,
        :created_at => post.created_at,
        :user_id => post.user_id,
        :author_name => User.find_by(id: post.user_id).full_name,
        :formatted_time => post.created_at.strftime("on %d/%m/%Y at %k:%M"),
        :comments => post_comments,
        :likes => post_likes,
        :current_user_liked => !Like.find_by(post_id: post.id, user_id: session[:user_id]).nil?
      }
    end
    p @posts_with_username
    @posts_with_username = @posts_with_username.reverse()
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end
end
