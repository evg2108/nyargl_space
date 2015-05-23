module PresentersHelper
  def present(*args, &block)
    raise(MissingArgument, 'Empty arguments list') if args.empty?

    obj = args.shift
    if obj.is_a?(Hash)
      raise 'Presenter conflict. You may use :object parameter or :collection parameter, but not both' if obj[:object].present? && obj[:collection].present?

      object = obj.delete(:object)
      collection = obj.delete(:collection)
      options = obj
    else
      object = obj
      options = args.shift || {}
      raise 'Second parameter must be a Hash' unless options.is_a?(Hash)
    end

    presenter_name = options.delete(:presenter).to_s.classify if options[:presenter].present?
    presenter_name ||= object.class.to_s if object.present?
    presenter_name ||= collection.first.class.to_s if collection.present?

    raise 'Presenter name is not specified. Please use :presenter parameter' if presenter_name.blank?
    presenter_class = "#{presenter_name}Presenter".constantize

    if collection.present?
      if presenter_name
        presenter = collection.lazy.each_with_object([presenter_class, options]).map { |elem, (klass, opts)| klass.new(elem, self, opts) }
      else
        raise 'If you use :collection parameter, you also must specify :presenter parameter'
      end
    else
      presenter = "#{presenter_name}Presenter".constantize.new(object, self, options, &block)
    end

    collection.present? || block.nil? ? presenter : presenter.render
  end
end