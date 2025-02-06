class CartItemsController < ApplicationController
before_action :set_cart_item, only: %i[increase decrease destroy]

  def index
    #カート内アイテムを全て表示する 
    @cart_items = current_cart.cart_items.includes(:item)
    
  end

  def create
    increase_or_create(params.permit(:item_id)[:item_id])
    redirect_to root_path, notice:'商品が追加されました'
  end

  def increase
     if @cart_item == nil 
      @cart_item = current_cart.cart_items.build(item_id: params[:item_id])
      @cart_item.save
      @cart_item.increment!(:quantity, params.permit(:quantity)[:quantity].to_i)
      redirect_to item_path, notice:'商品が追加されました'
     else
      @cart_item.increment!(:quantity, params.permit(:quantity)[:quantity].to_i)
      redirect_to item_path(@cart_item.item_id), notice:'カートが更新されました'
      
     end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice:'カートが削除されました'
  end

  private

  def set_cart_item 
    #current_cartに関連するcart_itemの情報を取り出す
      @cart_item = current_cart.cart_items.find_by(id: params[:id]) || current_cart.cart_items.find_by(item_id: params[:item_id])
  end

  def increase_or_create(item_id)
    #カートに商品が入っていた時のcart_item
    cart_item = current_cart.cart_items.find_by(item_id: item_id) 
     if cart_item
      #cart_itemの商品の数が１つ増える。
      cart_item.increment!(:quantity, 1)
     else
      #初めてカートに商品を入れた時
      current_cart.cart_items.build(item_id: item_id).save 
     end
  end

end
