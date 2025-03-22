# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :promotion_code, optional: true
  attribute :total_price, :integer, default: 0

  before_save :update_total_price

  def total
    cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
  end

  def apply_code(promotion_code)
    # プロモーションコードが適応された時のdiscount_amount
    current_cart.update!(
      promotion_code_id: promotion_code.id,
      discount_amount: promotion_code.discount_amount,
      total_price: current_cart.cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity }
    )
  end

  def update_total_price
    self.total_price = cart_items.sum { |cart_item| cart_item.item.price * cart_item.quantity }
  end

  # 最終的な金額を定義
  def final_price
    total
    discount_amount
    [total - discount_amount, 0].max
  end
end
