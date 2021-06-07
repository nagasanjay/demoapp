class CreateFoodServices < ActiveRecord::Migration[6.1]
  def change
    create_table :food_services do |t|
      t.string :contact_number
      t.string :status
      t.json :time_interval

      t.timestamps
    end
  end
end
