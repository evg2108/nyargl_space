function initToggleButtons(error_callback) {
    $('form').on('click', 'input.toggle_button[type="submit"]', function(e) {
        e.preventDefault();
        var curr_button = $(this);
        var form = curr_button.closest('form');
        curr_button.addClass('disabled');
        $.ajax({
            url: form.attr('action') + '.json',
            method: form.attr('method'),
            data: form.serialize(),
            success: function() {
                var button = $('form input.toggle_button[type="submit"]');
                var curr_state = button.data('state');
                var changed_state = curr_state.toString() == 'true' ? 'false' : 'true';
                button.data('state', changed_state);
                button.val(button.data(changed_state + '-value'));
                var value_field = button.parent().find('input.toggle_button_value_field[type="hidden"]');
                value_field.val(curr_state);
                button.attr('data-original-title', button.data(changed_state + '-title'))
                    .tooltip('fixTitle')
                    .tooltip('show');
            },
            complete: function() {
                $('form input.toggle_button[type="submit"]').removeClass('disabled');
            },
            error: error_callback
        });
    });

    $('form').on('mouseenter', 'input.toggle_button[type="submit"]', function(e) {
        var _this = $(this);
        var state = _this.data('state').toString() == 'true';
        _this.val(_this.data(state + '-hover'));
        _this.removeClass('btn-danger');
        _this.removeClass('btn-success');
        _this.addClass(state ? 'btn-danger' : 'btn-success');
    });

    $('form').on('mouseleave', 'input.toggle_button[type="submit"]', function(e) {
        var _this = $(this);
        var state = _this.data('state').toString() == 'true';
        _this.val(_this.data(state + '-value'));
        _this.removeClass('btn-danger');
        _this.removeClass('btn-success');
        _this.addClass(state ? 'btn-success' : 'btn-danger');
    });
}