//= require common
//= require shared/components/toggle_button_input
//= require jcrop.js
//= require shared/hacks/detect_ie_version.js
//= require shared/custom/dropzone
//= require shared/components/remote_forms
//= require_self

function _error_callback(xhr) {
    noty_error_callback(xhr.responseJSON.message);
}

$(document).ready(function() {
    initToggleButtons(_error_callback);

    if (!document.ieDetector.isIE || document.ieDetector.Version > 9) {
        document.jcrop.init({
            file_input_id: 'author_avatar',
            after_change: function () {
                $('#cropper').modal({});
            }
        });
    } else {
        $('.bad_browser_submit_btn').show();
    }

    document.dropzone.init('author_photos_upload_form_dropzone', { paramName: 'author[photos]', uploadMultiple: true, parallelUploads: 5 });

    document.remote_forms.init('.previews', '.image_remove_form', {
        success: function(xhr) {
            $('form#preview_' + xhr.responseJSON.name).closest('.preview').remove();
        }
    });
});