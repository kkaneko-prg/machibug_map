class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index new create]
  before_action :set_user, only: %i[destroy]

  def new
    @user = User.new
    # ログイン中の場合は、root_urlへリダイレクトする。
    redirect_to root_url if logged_in?
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

  def destroy
    @user.destroy
    redirect_to root_path, success: t('.success')
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
