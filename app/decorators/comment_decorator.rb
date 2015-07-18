class CommentDecorator < Draper::Decorator
  delegate_all

  def lead(length = 230)
    h.truncate(description, length: length, separator: ' ')
  end

  def comment_author_name
    return '<strong class="text-muted">[Автор не указан]</strong>'.html_safe unless commentator
    if commentator.author && commentator.author.enabled
      h.link_to commentator.author.full_name, h.author_path(commentator.author)
    else
      commentator.nickname || '<strong class="text-muted">[Безымянный]</strong>'.html_safe
    end
  end

  def content_formatted
    result = []
    content.split("\n").each do |paragraph|
      result << h.content_tag(:p, paragraph, class: 'text-justify') if paragraph.present?
    end
    result.join.html_safe if result.any?
  end
end
