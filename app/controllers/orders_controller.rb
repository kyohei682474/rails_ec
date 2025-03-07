# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :basic_auth_admin, only: %i[show index]

  def index
    @orders = Order.includes(:order_details).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    ActiveRecord::Base.transaction do
      @order = current_cart.orders.build(order_params)
      @order.save!
      create_order_detail(@order)
      cart_items_clear
    end
    # 購入するボタンが押されるとメールが送信できるようにする。
    send_order_email(@order)
    redirect_to root_path, notice: I18n.t('notices.order_thanks')
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "注文作成エラー: #{e.message}"
    flash.now[:alert] = I18n.t('notices.order_failed')
    render template: 'cart_items/index'
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :username, :email, :address,
                                  :address2, :country, :state, :zip, :payment_method,
                                  :cc_name, :cc_number, :cc_expiration, :cc_cvv)
  end

  

  # current_cartに紐づいているorder_detailオブジェクトを生成する
  def create_order_detail(order)
    current_cart.cart_items.each do |cart_item|
      order.order_details.create!(
        item_id: cart_item.item.id,
        item_name: cart_item.item.name,
        item_price: cart_item.item.price,
        quantity: cart_item.quantity
      )
    end
  end

  # カートの中身を全て削除するためのメソッド
  def cart_items_clear
    current_cart.cart_items.destroy_all
  end

  # メールを送信する機能
  def send_order_email(order)
    OrderMailer.with(order: order).order_detail_email.deliver_now
  end
end





