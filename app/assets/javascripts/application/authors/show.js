//= require layouts/application
//= require_self

$(document).ready(function () {
    $('.media-container').append($('<div>', { class: 'controls' }));
    $('.media-container .controls').append($('<a>', { class: 'prev_arrow', href: '#' }));
    $('.media-container .controls').append($('<a>', { class: 'next_arrow', href: '#' }));

    $('.media-container').on('click', '.controls a', function(e) {
        e.preventDefault();

        var $this = $(this);
        var $visible_pic = $('.media-container .images .image.show');

        if ($this.hasClass('prev_arrow')) {
            var prev = $visible_pic.prev();

            if (prev.length == 0) {
                prev = $visible_pic.siblings().last();
            }

            $visible_pic.removeClass('show');
            prev.addClass('show');
        } else if ($this.hasClass('next_arrow')) {
            var next = $visible_pic.next();

            if (next.length == 0) {
                next = $visible_pic.siblings().first();
            }

            $visible_pic.removeClass('show');
            next.addClass('show');
        }
    });
});