class BlogsController < ApplicationController
  expose(:blogs)
  expose(:blog, attributes: :permitted_params)

  def create
    if blog.save
      set_simple_success_message 'Вы успешно создали новый блог. Теперь вы можете писать для него посты.'
      redirect_to blog_path(blog)
    else
      set_simple_error_message 'Вам не удалось создать блог. Все ли обязательные поля вы заполнили?'
      redirect_to new_blog_path
    end
  end
end