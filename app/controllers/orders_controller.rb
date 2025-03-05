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
      current_cart.cart_items.destroy_all
    end
    # 購入するボタンが押されるとメールが送信できるようにする。
    OrderMailer.with(order: @order).order_detail_email.deliver_now
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

  def basic_auth_admin
    authenticate_or_request_with_http_basic do |username, password|
      (username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']) || render(
        plain: '認証に失敗しました。正しい認証情報を入力してください。', status: :unauthorized
      )
    end
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
end
