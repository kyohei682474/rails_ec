# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  before_action :current_cart
  def apply
    @promotion_code = PromotionCode.find_by(code: params[:promotion_code])

    if @promotion_code.present? && !@promotion_code.used?
      current_cart.apply_code(@promotion_code)
      session[:applied_promotion_code] = @promotion_code.code # セッションにpromotion_code.codeを保存
    elsif @promotion_code.present? && @promotion_code.used?
      flash[:alert] = t('flash.promotion_codes.already_used')
    else
      flash[:alert] = t('flash.promotion_codes.invalid')
    end
    redirect_to cart_items_path
  end
end
