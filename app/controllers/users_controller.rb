class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[index new create]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
    # 現在ログイン中の時は、rootへリダイレクトする。
    if logged_in?
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録が成功したら、そのままログインが完了した状態になる。
      auto_login(@user)
      redirect_to root_url, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
