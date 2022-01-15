class LikesController < ApplicationController
  skip_before_action :require_login, only: %i[create]  
  # いいねをする
  def create
    if logged_in?
      @like = current_user.likes.create(post_id: params[:post_id])
      # 直前のページに戻れなかったら、root_pathへ飛ぶ。
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path
      flash[:alert] = "ログインが必要です。"
    end
  end

  # いいねを取消す
  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    # 直前のページに戻れなかったら、root_pathへ飛ぶ。
    redirect_back fallback_location: root_path
  end
end
