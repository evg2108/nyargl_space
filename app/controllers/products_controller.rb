class ProductsController < ApplicationController
  include Pundit
  include SimpleResourceLoader

  self.per_page = 10
end