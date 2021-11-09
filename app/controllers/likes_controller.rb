class LikesController < ApplicationController

    

    def create
        @likes = Like.create(likes_params)
        redirect_to posts_url
      end

    
    
      private
    
      def likes_params
        params.require(:likes.permit(:user_id, :post_id)
      end

    
end
