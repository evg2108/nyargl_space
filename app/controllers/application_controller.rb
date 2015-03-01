class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Then, when you'd like parameters to be assigned to a model, add the attributes option to your exposure:
  # class FooController < ApplicationController
  #   expose(:foo, attributes: :foo_params)
  #
  #   private
  #   def foo_params
  #     params.require(:foo).permit(:bar, :baz)
  #   end
  # end
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  expose(:menu_items){
    [
        MenuItem.new(:authors, :authors, :index),
        MenuItem.new(:articles, :articles, :index),
        MenuItem.new(:blogs, :blogs, :index),
        MenuItem.new(:forums, :forums, :index),
    ]
  }
end
