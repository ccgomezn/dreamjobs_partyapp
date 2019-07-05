class Service < ApplicationRecord
  validates :name, :description, :price, presence: true

end
