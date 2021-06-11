class CreateFoodOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :food_orders do |t|
      t.integer :quantity
      t.decimal :cost
      t.references :food, null: false, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
