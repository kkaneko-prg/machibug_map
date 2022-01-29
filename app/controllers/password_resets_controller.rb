class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new
    # ログイン中の場合は、root_urlへリダイレクトする。
    redirect_to root_url if logged_in?
  end

  # パスワードを再設定したい対象のメールアドレスを入力・送信して、リセットの対象を作成する。
  def create
    @user = User.find_by(email: params[:email])
    # パスワードをリセットする方法（ランダムなトークンを含むURL）を記載したメールをユーザーに送信する。
    @user&.deliver_reset_password_instructions!
    # 「存在しないメールアドレスです」という旨の文言を表示すると、逆に存在するメールアドレスを特定されてしまうため、あえて成功時のメッセージを送信させている。
    redirect_to login_path, success: t('.success')
  end

  # パスワードリセット用のメールに記載されたURLをクリックして、パスワード再設定フォームから新しいパスワードを入力する。
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  # ユーザがパスワード再設定フォーム(editアクション)から、『update』ボタンをクリックすることでこのアクションが動いて、パスワードを変更する。
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?
    # パスワード確認の検証が機能する。
    @user.password_confirmation = params[:user][:password_confirmation]
    # 一時的なトークンをクリアし、パスワードを更新する。
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end
end
