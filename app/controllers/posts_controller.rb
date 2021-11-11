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
    redirect_to "/login" if !logged_in?
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
      Comment.where(post_id: post[:id]).each do |comment| 
        post_comments << comment_hash(comment)
      end

      @posts_with_username << post_hash(post, User.find_by(id: post.user_id), post_comments, post_likes)
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
      url_for(post.image_upload) : nil
  end

  def post_hash(post, user, comments,likes)
    {
        :id => post.id,
        :message => post.message,
        :created_at => post.created_at,
        :user_id => post.user_id,
        :author_name => User.find_by(id: post.user_id).full_name,
        :author_profile_photo => get_author_profile_photo(user),
        :post_image => get_post_image(post),
        :formatted_time => post.created_at.strftime("on %d/%m/%Y at %k:%M"),
        :comments => comments,
        :likes => likes,
        :current_user_liked => !Like.find_by(post_id: post.id, user_id: session[:user_id]).nil?
      }
  end

  def comment_hash(comment)
    comment_user = User.find_by(id: comment.user_id)
    {
      :id => comment.id,
      :message => comment.comment,
      :created_at => comment.created_at,
      :user_id => comment.user_id,
      :post_id => comment.post_id,
      :author_name => comment_user.full_name,
      :author_profile_photo => get_author_profile_photo(comment_user),
      :formatted_time => comment.created_at.strftime("on %d/%m/%Y at %k:%M"),
    }
  end
end
