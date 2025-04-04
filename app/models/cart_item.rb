# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  def line_total
    item.price * quantity
  end
end
