class PostsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    # N+1問題解消のため、postsテーブルからデータを取得する際に、関連するusersテーブルのデータも取得する。
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
    @post.build_spot
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to photos_url, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    # 投稿が削除されたら、写真もS3から削除する。
    @post.photos.purge && @post.destroy
    redirect_to root_url, success: t('.success')
  end

  private

  def post_params
    params.require(:post).permit(:caption, :address, photos: [], spot_attributes: %i[id address]).merge(user_id: current_user.id)
  end
end
