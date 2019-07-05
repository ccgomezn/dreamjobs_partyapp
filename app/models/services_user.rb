class ServicesUser < ApplicationRecord
  validates :user_id, :service_id, :city, :country, :address, presence: true
  belongs_to :user
  belongs_to :service

end
