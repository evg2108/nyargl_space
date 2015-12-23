#coding: utf-8

#TODO Пока не понятно как сделать чтобы уникальные имена файлов не генерировались заново при добавлении новых файлов
## или при удалении существующих. Это мешает использовать приемущества AJAX. Задал вопрос в issues CarrierWave на github
module Profile
  class ProductPicturesController < Profile::BaseController
    expose(:product)

    def create
      pictures = product.pictures_identifiers
      product.pictures += get_photos
      result = product.save

      respond_to do |f|
        f.html do
          result ? set_success_message(:product, :pictures, :upload) : set_error_message(:product, :pictures, :upload)
          redirect_to edit_profile_product_path(product, anchor: Anchors::Profile::PRODUCT_PICTURES)
        end

        f.json do
          if result
            render json: { names: product.pictures_identifiers - pictures }
          else
            render json: { message: 'failed to add new photo' }, status: :internal_server_error
          end
        end
      end
    end

    def destroy
      picture_name = params[:id]
      photo_for_deleting = product.pictures.detect { |photo| photo.file.basename == picture_name}
      if photo_for_deleting
        photo_for_deleting.remove!
        product.pictures -= [photo_for_deleting]
        product.remove_pictures! if product.pictures.empty?
        result = product.save
      end

      respond_to do |f|
        f.html do
          result ? set_success_message(:product, :pictures, :remove) : set_error_message(:product, :pictures, :remove)
          redirect_to edit_profile_product_path(product, anchor: Anchors::Profile::PRODUCT_PICTURES)
        end

        f.json do
          if result
            render json: { name: picture_name }
          else
            render json: { message: "failed to remove #{picture_name} photo" }, status: :internal_server_error
          end
        end
      end
    end

    private

    def get_photos
      params.required(:product).required(:pictures).values
    end

    def do_authorize
      if %w(create destroy).include?(action_name)
        authorize product || Author, :update?
      else
        super
      end
    end
  end
end