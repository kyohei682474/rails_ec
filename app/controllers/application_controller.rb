# frozen_string_literal: true

class ApplicationController < ActionController::Base
    helper_method :current_cart
  private

    def current_cart
      if session[:cart_id]
        @current_cart ||= Cart.find_by(id: session[:cart_id])
      else
        @current_cart = Cart.create
        session[cart_id] = cart.id
      end
        @current_cart
    end 
end
