class ProductsController < ApplicationController
  include Pundit
  include SimpleResourceLoader

  self.per_page = 10

  expose(:comments) { product.comments.only_enabled.order(created_at: :desc).decorate }
  expose(:comment) { product.comments.new }
end