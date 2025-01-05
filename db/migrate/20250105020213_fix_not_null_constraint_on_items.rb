class FixNotNullConstraintOnItems < ActiveRecord::Migration[7.0]
    def change
      change_table :items, bulk: true do |t|
        t.change :name, :string, null: false
        t.change :price, :integer, null: false
      end
    end
end
