# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[increase destroy]
  before_action :current_cart

  def index
    # カート内アイテムを全て表示する
    @cart_items = @current_cart.cart_items.includes(:item)
    @total = current_cart.total
    # 住所やクレジット情報を記入するための@order
    @order = Order.new
  end

  def create
    increase_or_create(params.permit(:item_id)[:item_id])
    redirect_to root_path, notice: t('cart_items.added')
  end

  def increase
    if @cart_item.nil?
      @cart_item = current_cart.cart_items.build(item_id: params[:item_id])
      @cart_item.save
      @cart_item.increment(:quantity, params.permit(:quantity)[:quantity].to_i)
      @cart_item.save
      @cart.update_total_price
      @cart.save
      redirect_to item_path(@cart_item.item_id), notice: t('cart_items.added')
    else
      @cart_item.increment(:quantity, params.permit(:quantity)[:quantity].to_i)
      @cart_item.save
      @cart.update_total_price
      @cart.save
      redirect_to item_path(@cart_item.item_id), notice: t('cart_items.updated')
    end
  end
  # rubocop:enable Hc/RailsSpecificActionName

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice: t('cart_items.deleted')
  end

  private

  def set_cart_item
    # current_cartに関連するcart_itemの情報を取り出す
    @cart_item = current_cart.cart_items.find_by(id: params[:id]) ||
                 current_cart.cart_items.find_by(item_id: params[:item_id])
  end

  def increase_or_create(item_id)
    # カートに商品が入っているか確認を行う
    cart_item = @current_cart.cart_items.find_by(item_id: item_id)
    if cart_item
      # cart_itemの商品の数が１つ増える。
      cart_item.increment(:quantity, 1)
      cart_item.save
    else
      # 初めてカートに商品を入れた時
      current_cart.cart_items.build(item_id: item_id).save
    end
    current_cart.update_total_price
    current_cart.save
  end
end
