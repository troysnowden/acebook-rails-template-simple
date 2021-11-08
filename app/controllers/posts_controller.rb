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
    
    Post.all.each do |post|
      @posts_with_username << {
        :id => post.id,
        :message => post.message,
        :created_at => post.created_at,
        :user_id => post.user_id,
        :author_name => User.find_by(id: post.user_id).full_name
      }
    end
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end
end
