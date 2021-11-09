class LikesController < ApplicationController

    def create
        @likes = Like.create(likes_params)
        redirect_to posts_url
      end

      def index
        if @clicks != nil
          @clicks = @clicks + 1
        else
          @clicks = 0
        end
      end
    
    
      private
    
      def likes_params
        params.require(:likes.permit(:user_id, :post_id)
      end

    
end
