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

  def in_few_words
    h.truncate(about_author, length: 230, separator: ' ')
  end

  def about_author_formatted
    result = []
    about_author.split("\n").each do |paragraph|
      result << h.content_tag(:p, paragraph, class: 'text-justify') if paragraph.present?
    end
    result.join.html_safe if result.any?
  end

end
