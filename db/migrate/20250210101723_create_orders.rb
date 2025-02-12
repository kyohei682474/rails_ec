# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :cart, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false
      t.string :email, null: false
      t.string :address, null: false
      t.string :address2
      t.string :country, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :payment_method, null: false
      t.string :cc_name, null: false
      t.string :cc_number, null: false
      t.string :cc_expiration, null: false
      t.string :cc_cvv, null: false
      t.boolean :same_address, null: false
      t.boolean :save_info, null: false
      t.integer :total_price, null: false

      t.timestamps
    end
  end
end
