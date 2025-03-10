# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id])

    return if @current_cart

    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id # 正しくカートIDを保存
  end

  def basic_auth_admin
    authenticate_or_request_with_http_basic do |username, password|
      (username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']) || render(
        plain: '認証に失敗しました。正しい認証情報を入力してください。', status: :unauthorized
      )
    end
  end
end
