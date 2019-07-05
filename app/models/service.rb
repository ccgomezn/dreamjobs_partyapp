# frozen_string_literal: true

class Service < ApplicationRecord
  validates :name, :description, :price, presence: true
  has_many :services_user
end
