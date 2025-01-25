# frozen_string_literal: true

class ApplicationController < ActionController::Base
    helper_method :current_cart


    def current_cart
     @current_cart ||= Cart.find_by(id: session[cart_id]) || begin
                       cart = Cart.create
                       session[cart_id] = cart.id
                       cart
                       end  
    end
     
end
