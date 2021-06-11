class CreateStayOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :stay_orders do |t|
      t.decimal :cost
      t.references :stay_options, null: false, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
