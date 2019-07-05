class CreateServicesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :services do |t|
      t.string :address, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.integer :employee_id, references: [:employees, :id]
      t.integer :rating
      t.integer  :id, primary_key: true, :serial

    end
  end
end
