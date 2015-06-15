//= require layouts/application
//= require shared/application/noty_error_callback.js
//= require_self

function initFormBindings(success_callback, error_callback) {
    $('#change_password form').on('click', 'input[type="submit"]', function (e) {
        e.preventDefault();
        var curr_button = $(this);
        var form = curr_button.closest('form');
        curr_button.addClass('disabled');
        $.ajax({
            url: form.attr('action') + '.json',
            method: form.attr('method'),
            data: form.serialize(),
            success: success_callback,
            complete: function () {
                var change_pass_form = $('#change_password form');
                change_pass_form.find('input[type="submit"]').removeClass('disabled');
                change_pass_form.find('input#user_password').val('');
            },
            error: error_callback
        });
    });
}

function _success_callback(result) {
    noty_success_callback(result.message)
}

function _error_callback(xhr) {
    noty_error_callback(xhr.responseJSON.message)
}

$(document).ready(function(){
    initFormBindings(_success_callback, _error_callback);
});