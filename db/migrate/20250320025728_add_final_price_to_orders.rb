# frozen_string_literal: true

class AddFinalPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :final_price, :integer, null: false, default: 0
  end
end
