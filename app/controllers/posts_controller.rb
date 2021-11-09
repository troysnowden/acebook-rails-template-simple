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
      @posts_with_username << post_hash(post, post_user)
    end
    @posts_with_username.reverse!
  end

  private

  def post_params
    params.require(:post).permit(:message, :user_id, :image_upload)
  end

  def get_author_profile_photo(author)
    author.profile_photo.attached? ? 
       url_for(author.profile_photo) : "eggheads/egghead#{Random.rand(3) + 1}.png"
  end

  def get_post_image(post)
    post.image_upload.attached? ? 
      url_for(post.image_upload) : "eggheads/egghead#{Random.rand(3) + 1}.png"
  end

  def post_hash(post, user)
    {
      :id => post.id,
      :message => post.message,
      :created_at => post.created_at,
      :user_id => post.user_id,
      :author_name => user.full_name,
      :author_profile_photo => get_author_profile_photo(user),
      :post_image => get_post_image(post),
      :formatted_time => post.created_at.strftime("on %d/%m/%Y at %k:%M")
    }
  end
end
