class LikesController < ApplicationController
  skip_before_action :require_login, only: %i[create]  
  # いいねをする
  def create
    if logged_in?
      @post = Post.find(params[:post_id])
      current_user.likes.create(post_id: @post.id)
    else
     redirect_back fallback_location: root_path
     flash[:alert] = "ログインが必要です。"
    end
  end

  # いいねを取消す
  def destroy
    @post = current_user.likes.find(params[:id]).post
    current_user.liked_posts.destroy(@post)
  end
end    
