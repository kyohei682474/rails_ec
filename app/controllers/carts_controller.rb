class CartsController < ApplicationController
  def show
    @cart = current_cart.cart_items.include(:item)
  end
end
