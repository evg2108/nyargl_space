# encoding: utf-8

class UserAvatarUploader < BaseUploader
  process crop: [100, 100]
end
