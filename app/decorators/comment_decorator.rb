class CommentDecorator < Draper::Decorator
  delegate_all

  def lead(length = 230)
    h.truncate(description, length: length, separator: ' ')
  end

  def comment_author_name
    return h.content_tag(:span, '[Автор не указан]', class: 'text-muted') unless commentator
    author_name(commentator)
  end

  def reply_author_name
    output = ActionView::OutputBuffer.new
    if reply_commentator
      output << h.content_tag(:span, class: 'label label-default') do
        h.content_tag(:span, nil, class: 'glyphicon glyphicon-share-alt')
      end
      output << h.content_tag(:span, author_name(reply_commentator), class: 'label')
    end
    output
  end

  def content_formatted
    result = []
    content.split("\n").each do |paragraph|
      result << h.content_tag(:p, paragraph, class: 'text-justify') if paragraph.present?
    end
    result.join.html_safe if result.any?
  end

  def commentator_avatar(options = {})
    return h.image_tag(h.image_path_or_placeholder(User.new, :avatar), options) unless commentator
    if commentator.author && commentator.author.enabled
      h.link_to h.author_path(commentator.author) do
        h.image_tag(h.image_path_or_placeholder(commentator.author, :avatar), options)
      end
    else
      h.image_tag(h.image_path_or_placeholder(commentator, :avatar), options)
    end
  end

  private

  def author_name(user)
    if user.author && user.author.enabled
      h.link_to user.author.full_name, h.author_path(user.author)
    else
      user.nickname || h.content_tag(:span, '[Безымянный]', class: 'text-muted')
    end
  end
end
