class User < ActiveRecord::Base

  validates :email, presence: true, email: true
  validates :password, presence: true

  has_secure_password
end
