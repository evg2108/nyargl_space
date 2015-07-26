class User < ActiveRecord::Base
  include Roles

  has_one :author, dependent: :destroy
  has_many :products, dependent: :nullify

  has_secure_password

  mount_uploader :avatar, UserAvatarUploader

  validates :email, presence: true, uniqueness: true, email: true
  validates :password_digest, presence: true

  before_save :fix_empty_role

  def role
    read_attribute(:role) || Roles.default_role
  end

  private

  def fix_empty_role
    self.role = Roles.default_role if read_attribute(:role).nil?
  end

end
