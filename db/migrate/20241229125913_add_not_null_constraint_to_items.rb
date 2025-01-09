# frozen_string_literal: true

class AddNotNullConstraintToItems < ActiveRecord::Migration[7.0]
  def up
    change_table :items, bulk: true do |t|
      t.change :name, :string, null: false
      t.change :price, :integer, null: false
    end
  end

  def down
    change_table :items, bulk: true do |t|
      t.change :name, :string, null: true
      t.change :price, :integer, null: true
    end
  end
end
