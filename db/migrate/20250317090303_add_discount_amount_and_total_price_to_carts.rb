# frozen_string_literal: true

class AddDiscountAmountAndTotalPriceToCarts < ActiveRecord::Migration[7.0]
  change_table :carts, bulk: true do |t|
    t.integer :discount_amount, default: 0, null: false
    t.integer :promotion_code_id
  end
end
