class CommentsController < ApplicationController
  expose(:comment, attributes: :permitted_params)

  before_filter :set_commentator, only: [:create, :update]

  def create
    result = comment.save

    respond_to do |f|
      f.html do
        set_simple_error_message comment.errors.full_messages unless result
        redirect_to(request.env['HTTP_REFERER'].presence || root_path)
      end
      f.json do
        if result
          render json: { result: render_to_string(partial: 'comments/comment_item', object: comment.decorate, formats: [:html]) }
        else
          render json: { message: simple_error_message(comment.errors.full_messages) }, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    comment.destroy
    respond_to do |f|
      f.html do
        redirect_to("#{request.env['HTTP_REFERER'].presence}#comments" || root_path)
      end
      f.json do
        render json: { id: comment.id }
      end
    end
  end

  private

  def set_commentator
    comment.commentator = current_user unless current_user.guest?
  end
end