class CartItemsController < ApplicationController
before_action :set_cart, only: %i[increase decrease destroy]

  def index 
  #   @cart_items = current_cart.cart_items.include(:item_id)
  end

  def create
    increase_or_create(params.permit(:item_id)[:item_id])
    redirect_to root_path, notice:'商品が追加されました'
  end

  def increase
     if @cart_item == nil
      Rails.logger.debug "Params: #{params.inspect}" 
      @cart_item = current_cart.cart_items.build(item_id: params[:item_id]).save
      @cart_item.increment!(:quantity, params.permit(:quantity)[:quantity].to_i)
      redirect_to item_path, notice:'カートが更新されました'
     else
      @cart_item.increment!(:quantity, params.permit(:quantity)[:quantity].to_i)
      redirect_to item_path(@cart_item.item_id), notice:'カートが更新されました'
      
     end
  end


  def decrease
    decrease_or_destroys
    redirect_to cart_items_path, notice:'カートが更新されました'
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice:'カートが削除されました'
  end

  private

  def set_cart 
    #カートの中に商品が入っている場合にセットしておく
      @cart_item = current_cart.cart_items.find_by(item_id: params.permit(:item_id)[:item_id])
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

  def decrease_or_destroy(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:quantity, 1)
    else
      cart_item.destroy
    end
  end

end
