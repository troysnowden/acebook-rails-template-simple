class LikesController < ApplicationController

    def create
        @like = Like.create(like_params)
        redirect_to posts_url
      end
      private
    
      def like_params
        params.require(:like).permit(:user_id, :post_id)
      end

end
