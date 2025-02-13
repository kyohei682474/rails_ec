# frozen_string_literal: true

class RemoveSameAddressSaveInfoTotalPriceFromOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders, bulk: true do |t|
      t.boolean :same_address, default: false, null: false
      t.boolean :save_info, default: false, null: false
    end
  end
end
