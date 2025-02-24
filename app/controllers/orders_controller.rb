# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @order = current_cart.orders.build(order_params)
    if @order.save!
      #order_detailオブジェクトを生成する
      current_cart.cart_items.each do |cart_item|
        @order.order_detail.create(
          item_name: cart_item.item.name,
          item_price: cart_item.item.item_price,
          quantity: cart_item.quantity
        ) 
        
      end

      current_cart.cart_itmes.destroy_all

      #購入するするボタンが押されるとメールが送信できるようにする。
      OrderMailer.with(order: @order).order_detail_email.deliver_now
      
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
