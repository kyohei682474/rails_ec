# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  belongs_to :promotion_code, optional: true 

  def update_total_price
    self.total_price = cart_items.sum{ |cart_item| cart_item.item.price * cart_item.quantity }
  end
  # 最終的な金額を定義
  def final_price
    total_price - discount_amount
  end
end
