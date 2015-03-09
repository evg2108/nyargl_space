# This concern module define methods for storing objects in file storage with linking to session
#
# usage:
#
# for save object attributes to storage use method save_to_session_file_storage(object, *serialized_attributes)
# for check existence object in storage use method in_session_file_storage?(model_name)
# for restore object from storage use method read_from_session_file_storage(klass)
#
# after reading object from storage they removes from storage and form session
#
#   class UsersController < ApplicationController
#     include SessionFileStorage
#
#     expose(:user) do
#       if params[:user]
#         User.new(user_params)
#       elsif in_session_file_storage?(:user)
#         read_from_session_file_storage(User)
#       else
#         User.new
#       end
#     end
#
#     def create
#       if user.save
#         redirect_to root_path
#       else
#         save_to_session_file_storage(user, :email, :password)
#         redirect_to new_user_path
#       end
#     end
#
#     private
#
#     def user_params
#       params.require(:user).permit(:email, :password)
#     end
#   end
#
module SessionFileStorage
  include ActiveSupport::Concern

  private

  def push_to_storage(key, val)
    storage.write(key, val, expires_in: 1.minute)
  end

  def pop_from_storage(key)
    result = storage.read(key)
    storage.delete(key)
    result
  end

  def storage
    @_file_cache_storage ||= ActiveSupport::Cache::FileStore.new(Rails.root + 'tmp' + 'session_file_storage' + self.controller_name)
  end

  def save_to_session_file_storage(object, *serialized_attributes)
    user_identifier = object.hash
    push_to_storage(user_identifier, serialized_attributes.map{ |attr| [attr, object.send(attr) ] }.to_h )
    session["sfs_#{object.model_name.singular}"] = user_identifier
  end

  def read_from_session_file_storage(klass)
    obj = klass.new(pop_from_storage(session.delete("sfs_#{klass.model_name.singular}")))
    obj.valid?
    obj
  end

  def in_session_file_storage?(model_name)
    session["sfs_#{model_name}"].present?
  end
end