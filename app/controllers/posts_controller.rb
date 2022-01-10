class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @post.build_spot
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_url, success: t('.success')
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
    @post.destroy
    redirect_to posts_url, success: t('.success')
  end

  private

  def post_params
    params.require(:post).permit(:caption, :address, photos: [], spot_attributes: %i[id address]).merge(user_id: current_user.id)
  end
end
