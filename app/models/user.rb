class User < ActiveRecord::Base
  include Roles

  has_one :author, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true

  before_save :fix_empty_role

  def role
    read_attribute(:role) || Roles.default_role
  end

  private

  def fix_empty_role
    self.role = Roles.default_role if read_attribute(:role).nil?
  end

end
