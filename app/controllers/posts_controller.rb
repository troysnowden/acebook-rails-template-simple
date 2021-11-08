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
      post_user = User.find_by(id: post.user_id)
      author_profile_photo = post_user.profile_photo.attached? ? 
       url_for(post_user.profile_photo) : "eggheads/egghead#{Random.rand(3) + 1}.png"
      @posts_with_username << {
        :id => post.id,
        :message => post.message,
        :created_at => post.created_at,
        :user_id => post.user_id,
        :author_name => post_user.full_name,
        :author_profile_photo => author_profile_photo,
        :post_image => post.image_upload.attached? ? url_for(post.image_upload) : "eggheads/egghead#{Random.rand(3) + 1}.png",
        :formatted_time => post.created_at.strftime("on %d/%m/%Y at %k:%M")
      }
    end
    @posts_with_username = @posts_with_username.reverse()
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id, :image_upload)
  end
end
