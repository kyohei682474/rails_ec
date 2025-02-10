class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    oder
  end
end
