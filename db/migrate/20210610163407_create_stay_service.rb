class CreateStayService < ActiveRecord::Migration[6.1]
  def change
    create_table :stay_services do |t|
      t.string :contact_number
      t.string :status
      t.string :locality
      t.text :address

      t.timestamps
    end
  end
end
