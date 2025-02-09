# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :set_cart

  private

  def set_cart
    set_cart ||= Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= set_cart.id
    set_cart
  end
end
