class CommentsController < ApplicationController
  expose(:comment, attributes: :permitted_params)

  before_filter :set_commentator, only: [:create, :update]

  def create
    comment.save

    respond_to do |f|
      f.json
      f.html do
        set_simple_error_message comment.errors.full_messages unless comment.errors.present?
        redirect_to(request.env['HTTP_REFERER'].presence || root_path)
      end
    end
  end

  def edit
    respond_to do |f|
      f.html
      f.json
    end
  end

  def update
    comment.save

    respond_to do |f|
      f.html do
        redirect_to params[:redirect_to].presence || root_path
      end
      f.json
    end
  end

  def destroy
    comment.destroy
    respond_to do |f|
      f.json
      f.html do
        redirect_to("#{request.env['HTTP_REFERER'].presence}#comments" || root_path)
      end
    end
  end

  private

  def set_commentator
    comment.commentator = current_user unless current_user.guest?
  end
end