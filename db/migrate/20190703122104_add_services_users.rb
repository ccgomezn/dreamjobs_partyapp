class AddServicesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :services do |t|
      t.string :adress, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.integer :employee_id, null: false, references: [:employees, :id]
      
    end
  end
end
