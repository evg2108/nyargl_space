# encoding: utf-8

class AuthorAvatarUploader < BaseUploader
  process crop: [100, 100]
end
