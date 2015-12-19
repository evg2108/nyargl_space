class ProductDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def lead(length = 230)
    h.truncate(description, length: length, separator: ' ')
  end

  def age_restriction_label
    color_class = case object.age_restriction.to_sym
                    when :ar0, :ar6
                      'label-success'
                    when :ar16, :ar12
                      'label-warning'
                    else
                      'label-danger'
                  end
    h.content_tag :span, class: ['age_restriction', 'label', color_class] do
      I18n.t(object.age_restriction, scope: [:activerecord, :attributes, :product, :age_restriction])
    end
  end

  def price_label
    if object.price > 0
      h.content_tag :span, class: %w(price label label-primary) do
        h.number_to_currency object.price
      end
    else
      h.content_tag :span, 'бесплатно', class: %w(price label label-success)
    end
  end

  def description_formatted
    result = []
    return '' if description.blank?
    description.split("\n").each do |paragraph|
      result << h.content_tag(:p, paragraph, class: 'text-justify') if paragraph.present?
    end
    result.join.html_safe if result.any?
  end
end
