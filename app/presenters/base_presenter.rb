class BasePresenter < SimpleDelegator
  attr_reader :object

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end

  private

  def h
    @view_context
  end
end