# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @order = current_cart.orders.build(order_params)
    if @order.save!
      #購入するするボタンが押されるとメールが送信できるようにする。
      OrderMailer.with(order: @order).order_detail_email.deliver_now
      
      current_cart.cart_itmes.destroy_all
      redirect_to root_path, notice: I18n.t('notices.order_thanks')
    else
      flash.now[:alert] = I18n.t('notices. order_failed')
      render template: 'cart_items/index'
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :username, :email, :address, :address2, :country, :state,
                                  :zip, :payment_method, :cc_name, :cc_number, :cc_expiration, :cc_cvv)
  end
end
