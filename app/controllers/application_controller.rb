# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart

  # セッションIDに登録されているcart_idが確認できるか
  # できなければ、新たにカートオブジェクトを作成し、そのidをsession[:cart_id]に入れておく
  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id]) || create_cart
  end

  private 
    def create_cart
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
