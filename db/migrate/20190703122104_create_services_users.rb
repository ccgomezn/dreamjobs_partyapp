class CreateServicesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :services do |t|
      t.string :adress, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.integer :employee_id, references: [:employees, :id]
      t.integer :rating
    end
  end
end
