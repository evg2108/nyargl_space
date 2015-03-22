class AuthorDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def full_name
    full_name_array = []
    full_name_array << last_name if last_name.present?
    full_name_array << first_name
    full_name_array << patronymic if patronymic.present?

    full_name_array.join(' ')
  end

  def in_few_words
    h.truncate(about_author, length: 230, separator: ' ')
  end

end
