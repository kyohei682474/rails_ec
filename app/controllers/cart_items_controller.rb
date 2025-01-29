class CartItemsController < ApplicationController
before_action :set_cart, only: %i[increase decrease destroy]

  def index 
    @cart_items = current_cart.cart_items.include(:item_id)
  end

  def create
    increase_or_create(params.permit(:item_id)[:item_id])
    redirect_to root_path, notice:'商品が追加されました'
  end

  def increase
    @cart_item.increment!(:quantity, 1)
    redierct_to cart_item_path, notice:'カートが更新されました'
  end


  def decrease
    decrease_or_destroy
    redierct_to cart_items_path, notice:'カートが更新されました'
  end

  def destroy
    @cart_item.destroy
    redierct_to cart_items_path, notice:'カートが削除されました'
  end

  private

  def set_cart
    
    @cart_item = current_cart.cart_items.find_by(item_id: params[:item_id])
  end

  def increase_or_create(item_id)
    cart_item = current_cart.cart_items.find_by(item_id: item_id) 
     if cart_item
      cart_item.increment!(:quantity, 1)
     else
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
