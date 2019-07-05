# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :national_id, unique: true, null: false
    end
  end
end
