# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.string :national_id, unique: true, null: false
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.boolean :state, null: false, default: 0
      t.integer :user_type, null:false, default: 0
      t.string :user_token, null:false
    end
  end
end
