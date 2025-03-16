class PromotionCodesController < ApplicationController
  def apply
    promotion_code = PromotionCode.find_by(code: params[:promotion_code])
    if promotion_code.present && !promotion_code.used?
      apply_code(promotion_code)
    else
      
    end
  end

  private 

  def apply_code(promotion_code)
    discount = promotion_code.discount_amount
    @total -= discount 
  end
end
