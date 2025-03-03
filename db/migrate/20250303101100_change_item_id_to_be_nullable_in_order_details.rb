# frozen_string_literal: true

class ChangeItemIdToBeNullableInOrderDetails < ActiveRecord::Migration[7.0]
  def change
    change_column_null :order_details, :item_id, true
  end
end
