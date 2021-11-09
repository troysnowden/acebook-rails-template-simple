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
    @user_id = session[:user_id]
    p @user_id
    
    Post.all.each do |post| 
      @posts_with_username << {
        :id => post.id,
        :message => post.message,
        :created_at => post.created_at,
        :user_id => post.user_id,
        :author_name => User.find_by(id: post.user_id).full_name,
        :formatted_time => post.created_at.strftime("on %d/%m/%Y at %k:%M"),
        :comments => [
            {:message => "great post!", :user_id => 2, :created_at => "03/11/2021 at 07:48"},
            {:message => "jinkies!", :user_id => 2, :created_at => "08/11/2021 at 11:48"}
          ]
      }
    end
    @posts_with_username = @posts_with_username.reverse()
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id)
  end
end
