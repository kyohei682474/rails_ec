# frozen_string_literal: true

class RemoveSameAddressSaveInfoTotalPriceFromOrders < ActiveRecord::Migration[7.0]
  def up
    change_table :orders, bulk: true do |t|
      t.remove :same_address, :save_info, :total_price
    end
  end

  def down
    change_table :orders, bulk: true do |t|
      t.boolean :same_address, default: false, null: false
      t.boolean :save_info, default: false, null: false
      t.integer :total_price
    end
  end
end
