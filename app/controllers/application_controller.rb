class ApplicationController < ActionController::Base
  include Pundit
  include AuthenticationHelper
  include FlashMessenger
  include PageTitleHelper
  include StrongParamsManager

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
        MenuItem.new(:authors, :index),
        MenuItem.new(:products, :index),
        MenuItem.new(:blogs, :index),
        MenuItem.new(:forums, :index),
    ]
  }

  expose(:last_comments) { Comment.only_enabled.order(created_at: :desc).limit(5).decorate }
end
