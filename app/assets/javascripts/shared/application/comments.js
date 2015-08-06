(function($) {
    var internal = {};

    internal.bind_edit_button = function(parent, selector) {
        $(parent).on('click', selector, function(e) {
            e.preventDefault();

            var $this = $(this);

            $.ajax({
                url: $this.attr('href'),
                method: 'GET',
                dataType: 'json',
                error: function(xhr, response_status, error_name) {
                    //noty_error_callback(xhr.responseJSON.message)
                },
                success: function(result, status, xhr) {
                    //$('.comments_list').prepend(result.result);
                    //$('form textarea').val('');

                }
            });
        });
    };

    $(document).ready(function() {
        internal.bind_edit_button('.comments_list', '.comment_actions a.edit');
    });
})(jQuery);



