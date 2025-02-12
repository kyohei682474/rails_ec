# frozen_string_literal: true

class RemoveSameAddressSaveInfoTotalPriceFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :same_address, :boolean
    remove_column :orders, :save_info, :boolean
    remove_column :orders, :total_price, :integer
  end
end
