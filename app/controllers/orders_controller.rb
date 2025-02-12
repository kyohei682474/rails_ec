# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @order = Order.new(order_params)
  end

  def create
    @order = Order.new(order_params)
    @order.cart = set_cart

    if @order.save!
      redirect_to root_path, notice: '購入ありがとうございます'
    else
      render cart_items_path, noteice: '購入に失敗しました'
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :username, :email, :address, :address2, :country, :state,
                                  :zip, :payment_method, :cc_name, :cc_number, :cc_expiration, :cc_cvv)
  end
end
