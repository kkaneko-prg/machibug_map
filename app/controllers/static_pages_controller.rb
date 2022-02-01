class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[about howto terms privacy]
  # とは？
  def about; end

  # 使い方
  def howto; end

  # ご利用規約
  def terms; end

  # プライバシーポリシー
  def privacy; end
end
