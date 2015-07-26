//= require layouts/application
//= require shared/application/image_slider
//= require shared/application/noty_callbacks
//= require shared/application/remote_forms
//= require_self

$(document).ready(function () {
    document.image_slider.init();

    document.remote_forms.init('section.comments', '#new_comment', {
        error: function(xhr, response_status, error_name) {
            noty_error_callback(xhr.responseJSON.message)
        },
        success: function(result, status, xhr) {
            $('.comments_list').prepend(result.result);
            $('form textarea').val('');
        }
    });

    document.remote_forms.init('section.comments', '.edit_comment', {
        success: function(result, status, xhr) {
            $('article.comment#' + result.id).remove();
        }
    });
});