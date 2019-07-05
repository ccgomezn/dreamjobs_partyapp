# frozen_string_literal: true

class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :price, null: false
    end
  end
end
