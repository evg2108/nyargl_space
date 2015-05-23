class BasePresenter
  attr_reader :object

  def initialize(object, view_context, options, &block)
    @object = object
    @view_context = view_context
    @options = options
    if block_given?
      @content = h.capture(self, &block)
    end
  end

  def render
    @content
  end

  private

  def h
    @view_context
  end

  def method_missing(symbol, *args)
    if @object
      @object.public_send(symbol, *args)
    else
      super
    end
  end
end