class User < ApplicationRecord
  before_create :user_token_creation

  has_secure_password
  validates :email, :password, :phone_number, :name, :national_id, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }
  has_many :services_user

  def user_activate
    self.state = true
    save!(validate: false)
  end
  def user_desactivate
    self.state = false
    save!(validate: false)
  end
  private

  def user_token_creation
    if self.user_token.blank?
      self.user_token = SecureRandom.urlsafe_base64.to_s
    end
    true
  end
end
