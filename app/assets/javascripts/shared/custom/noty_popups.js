//= require vendor/jquery.noty.packaged.min
//= require_self

function noty_popups_show() {
    var message_blocks = $('.popup_message');

    if (message_blocks.length > 0) {
        message_blocks.each(function(index, elem) {
            var element = $(elem);
            noty_show_message(element.data('message'), element.data('message-type'));
        });
    }
}

function noty_show_message(message, type) {
    noty({
        text: message,
        type: type,
        layout: 'topCenter',
        timeout: 3000,
        animation: {
            open: 'animated flipInX', // jQuery animate function property object
            close: 'animated flipOutX', // jQuery animate function property object
            easing: 'swing', // easing
            speed: 500 // opening & closing animation speed
        }
    });
}

function noty_error_callback(message) {
    noty_show_message(message, 'error');
}

function noty_success_callback(message) {
    noty_show_message(message, 'success');
}