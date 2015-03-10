module Roles
  extend ActiveSupport::Concern

  ROLE_NAMES = %i(admin user guest)

  included do
    class_eval do
      ROLE_NAMES.each do |role_name|
        define_method "#{role_name}?" do
          role_name.to_s == role
        end
      end
    end
  end

  ROLE_NAMES.each do |role_name|
    define_method "#{role_name}_role" do
      role_name.to_s
    end

    module_function "#{role_name}_role"
  end

  def default_role
    user_role
  end

  module_function :default_role
end