class CreatePromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :promotion_codes do |t|
      t.string :code, null: false, unique: true
      t.integer :discount_amount,null: false
      t.boolean :used, default: false

      t.timestamps
    end
    add_index :promotion_codes, :code, unique: true
  end
end
