# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :cart

  validates :final_price, presence: true

  def total_price
    order_details.sum { |order_detail| order_detail.item_price * order_detail.quantity }
  end
end
