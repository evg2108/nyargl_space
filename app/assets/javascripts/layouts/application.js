// This is a manifest file contains declaration requirements of scripts, that used on all pages
// for "application" layout.
//
// This file must be required on any js file for "application" layout
//
//= require jquery.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require vendor/noty/jquery.noty.packaged.min
//= require_self

$(document).ready(function() {
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

    $('#collapsed_menu').removeClass('in'); // if JS allowed
});