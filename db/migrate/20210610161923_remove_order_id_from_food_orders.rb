class RemoveOrderIdFromFoodOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :food_orders, :order_id
  end
end
