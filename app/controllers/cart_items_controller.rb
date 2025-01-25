class CartItemsController < ApplicationController
  def create
    increase_or_create.params([:cart_item][:item_id])
    redierct_to cart_item_path, notice:'商品が追加されました'
  end



  private

  def increase_or_create(item_id)
    cart_item = current_cart.cart_items.find_by(item_id) 
     if cart_item
      cart_item.increment!(:quantity, 1)
     else
      current_cart.cart_items.build(item_id).save  
     end
  end



end
