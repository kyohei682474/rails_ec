class AddDiscountAmountAndTotalPriceToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :discount_amount, :integer, default: 0, null: false 
    add_column :carts, :total_price, :integer, default: 0, null: false
  end
end
