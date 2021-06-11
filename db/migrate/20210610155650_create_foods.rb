class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.decimal :cost
      t.integer :units
      t.json :includes
      t.integer :available_count
      t.references :food_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
