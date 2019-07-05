# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :national_id, unique: true, null: false
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.integer :user_type, null:false, default: 0
    end
  end
end
