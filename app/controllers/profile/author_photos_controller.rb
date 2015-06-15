#coding: utf-8

#TODO Пока не понятно как сделать чтобы уникальные имена файлов не генерировались заново при добавлении новых файлов
## или при удалении существующих. Это мешает использовать приемущества AJAX. Задал вопрос в issues CarrierWave на github
module Profile
  class AuthorPhotosController < Profile::BaseController

    def create
      photos = current_author.photos_identifiers
      current_author.photos += get_photos
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
      photo_for_deleting = current_author.photos.detect { |photo| photo.file.basename == photo_name}
      if photo_for_deleting
        photo_for_deleting.remove!
        current_author.photos -= [photo_for_deleting]
        current_author.remove_photos! if current_author.photos.empty?
        result = current_author.save
      end

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
      [*params[:author][:photos]].flatten.select { |elem| elem.is_a?(ActionDispatch::Http::UploadedFile) }
    end

    def do_authorize
      if %w(create destroy).include?(action_name)
        authorize current_author || Author
      else
        super
      end
    end
  end
end