class ChangeCheckinCheckoutToStayOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :stay_orders, :checkin, :datetime
    change_column :stay_orders, :checkout, :datetime
  end
end
