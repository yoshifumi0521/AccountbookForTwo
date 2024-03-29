#coding: utf-8
#一番上のApplicationコントローラー
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  private
  #すべてのコントローラーのアクションの実行時にこの処理を行う。
  def authorize
    if cookies.signed[:user_id]
      #ログインユーザーのオブジェクトを@current_user変数にいれる。
      @current_user = User.find_by_id(cookies.signed[:user_id])
      cookies.delete :user_id unless @current_user
    end

  end





end
