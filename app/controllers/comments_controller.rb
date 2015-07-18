class CommentsController < ApplicationController
  expose(:comment, attributes: :comment_params)

  before_filter :set_commentator, only: [:create]

  def create
    result = comment.save

    respond_to do |f|
      f.html do
        set_simple_error_message comment.errors.full_messages unless result
        redirect_to(request.env['HTTP_REFERER'].presence || root_path)
      end
      f.js do
        if result
          render nothing: true
        else
          render json: { message: simple_error_message(comment.errors.full_messages) }, status: :unprocessable_entity, content_type: 'application/json'
        end
      end
    end
  end

  private

  def set_commentator
    comment.commentator = current_user
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_type, :commentable_id)
  end
end