class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    # ログイン中の場合は、root_urlへリダイレクトする。
    if logged_in?
      redirect_to root_url
    end
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_back_or_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, success: t('.success')
  end
end
