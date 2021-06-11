class AddCheckinCheckoutToStayOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :stay_orders, :checkin, :timestamp
    add_column :stay_orders, :checkout, :timestamp
  end
end
