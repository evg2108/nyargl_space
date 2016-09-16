//= require common
//= require shared/custom/dropzone
//= require shared/components/remote_forms
//= require_self

$(document).ready(function() {
    document.dropzone.init('product_pictures_upload_form_dropzone', { paramName: 'product[pictures]', uploadMultiple: true, parallelUploads: 5 });

    document.remote_forms.init('.previews', '.image_remove_form', {
        success: function(xhr) {
            $('form#preview_' + xhr.responseJSON.name).closest('.preview').remove();
        }
    });
});