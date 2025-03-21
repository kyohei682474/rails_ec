class AddPromotionCodeIdToCarts < ActiveRecord::Migration[7.0]
    def change
      add_column :carts, :promotion_code_id, :integer
      add_index :carts, :promotion_code_id
    end
end
