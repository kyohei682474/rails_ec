# frozen_string_literal: true

class AddDescriptionToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :description, :text, null: false, default: ''
  end
end
