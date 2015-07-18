//= require layouts/application
//= require shared/application/image_slider
//= require shared/application/noty_callbacks
//= require shared/application/remote_forms
//= require_self

$(document).ready(function () {
    document.image_slider.init();

    document.remote_forms.init('#new_comment', {
        error: function(event, xhr, status) {
            noty_error_callback(xhr.responseJSON.message)
        }
    });
});