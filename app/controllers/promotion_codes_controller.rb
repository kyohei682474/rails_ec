class PromotionCodesController < ApplicationController
  before_action: current_cart
  def apply
    promotion_code = PromotionCode.find_by(code: params[:promotion_code])
    binding.pry
    if promotion_code.present && !promotion_code.used?
      apply_code(promotion_code)
    elsif promotion_code.present && promotion_code.used?
     flash[:alert] = "このプロモーションコードはすでに使用されています。"
    else
     flash[:alert] = "無効なプロモーションコードです。"
    end

    redirect_to cart_items_path
      
  end

  private 

  def apply_code(promotion_code)
    #プロモーションコードが適応された時のdiscount_amount
    @cart.update!(
      discount_amount: promotion_code.discount_amount
      total_price: @cart.cart_items.sum {|cart_item| cart_item.item.price * cart_item.quantity }
    )
    promotion_code.used.change_used_status 
  end
end
