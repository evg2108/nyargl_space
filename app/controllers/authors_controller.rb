class AuthorsController < ApplicationController
  include SimpleResourceLoader

  self.per_page = 10
end
