class CreateOrderTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_types do |t|
      t.references :orderable, polymorphic: true, null: false
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
