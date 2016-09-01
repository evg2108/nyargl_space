#coding: utf-8

#TODO Пока не понятно как сделать чтобы уникальные имена файлов не генерировались заново при добавлении новых файлов
## или при удалении существующих. Это мешает использовать приемущества AJAX. Задал вопрос в issues CarrierWave на github
module Profile
  class AuthorPhotosController < Profile::BaseController

    def create
      photos = current_author.photos_identifiers
      current_author.append_photos get_photos
      result = current_author.save

      respond_to do |f|
        f.html do
          result ? set_success_message(:author, :photos, :upload) : set_error_message(:author, :photos, :upload)
          redirect_to profile_author_path(anchor: Anchors::Profile::AUTHOR_PHOTOS)
        end

        f.json do
          if result
            render json: { names: current_author.photos_identifiers - photos }
          else
            render json: { message: 'failed to add new photo' }, status: :internal_server_error
          end
        end
      end
    end

    def destroy
      photo_name = params[:id]
      current_author.remove_photo photo_name
      result = current_author.save

      respond_to do |f|
        f.html do
          result ? set_success_message(:author, :photos, :remove) : set_error_message(:author, :photos, :remove)
          redirect_to profile_author_path(anchor: Anchors::Profile::AUTHOR_PHOTOS)
        end

        f.json do
          if result
            render json: { name: photo_name }
          else
            render json: { message: "failed to remove #{photo_name} photo" }, status: :internal_server_error
          end
        end
      end
    end

    private

    def get_photos
      params.required(:author).required(:photos).values
    end

    def do_authorize
      if %w(create destroy).include?(action_name)
        authorize current_author || Author, :update?
      else
        super
      end
    end
  end
end