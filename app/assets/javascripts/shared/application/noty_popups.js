function noty_popups_show() {
    var message_blocks = $('.popup_message');

    if (message_blocks.length > 0) {
        message_blocks.each(function(index, elem) {
            var element = $(elem);
            noty({
                text: element.data('message'),
                type: element.data('message-type'),
                layout: 'topCenter',
                timeout: 3000,
                animation: {
                    open: 'animated flipInX', // jQuery animate function property object
                    close: 'animated flipOutX', // jQuery animate function property object
                    easing: 'swing', // easing
                    speed: 500 // opening & closing animation speed
                }
            });
        });
    }
}