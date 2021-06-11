class AddAvailabilityToStayOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :stay_services, :available, :boolean
  end
end
