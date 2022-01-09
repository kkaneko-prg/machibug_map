class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

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

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end     
  end

  def destroy
    @post.destroy
    redirect_to posts_url, success: t('.success') 
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
  #  params.require(:post).permit(:caption, :address, photos: [])
    params.require(:post).permit(:caption, :address, photos: [], spot_attributes: [:id, :address]).merge(user_id: current_user.id)
  end
end
