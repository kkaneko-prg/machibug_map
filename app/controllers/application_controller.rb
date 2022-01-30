class ApplicationController < ActionController::Base
  # デフォルトでrequire_loginをアクションの前に行う設定
  before_action :require_login
  # 使用可能なフラッシュメッセージの種類を追加
  add_flash_types :success, :info, :warning, :danger

  private

  # 未ログインユーザーがアクセスした際にrequire_loginで弾かれた場合の処理
  def not_authenticated
    redirect_to main_app.login_path, alert: 'ログインが必要です'
  end
end
