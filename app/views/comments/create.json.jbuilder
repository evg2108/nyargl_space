if comment.errors.blank?
  json.result render(partial: 'comments/comment_item', object: comment.decorate, formats: [:html])
else
  json.status 'error'
  json.message simple_error_message(comment.errors.full_messages)
end