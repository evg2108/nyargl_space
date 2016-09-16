//= require shared/components/remote_forms
//= require_self

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
                success: function(result, status, xhr) {
                    var $container = $('.edit_comment_form');
                    $container.html(result.result);
                    $container.removeClass('hidden');
                    var $hidden_container = $('.new_comment_form');
                    if (!$hidden_container.hasClass('hidden')) {
                        $hidden_container.addClass('hidden');
                    }
                }
            });
        });
    };

    $(document).ready(function() {
        document.remote_forms.init('section.comments', '.new_comment', {
            error: function(xhr) {
                noty_error_callback(xhr.responseJSON.message)
            },
            success: function(xhr) {
                $('.comments_list').prepend(xhr.responseJSON.result);
                $('form textarea').val('');
            }
        });

        document.remote_forms.init('section.comments', '.edit_comment', {
            error: function(xhr) {
                noty_error_callback(xhr.responseJSON.message)
            },
            success: function(xhr) {
                $('.comments_list').find('#comment_' + xhr.responseJSON.id + ' .body').html(xhr.responseJSON.text);
                var $edit_container = $('.edit_comment_form');
                $edit_container.html('');
                $edit_container.addClass('hidden');
                $('.new_comment_form').removeClass('hidden');
            }
        });

        document.remote_forms.init('section.comments', '.remove_comment_form', {
            success: function(xhr) {
                $('.comments_list #comment_' + xhr.responseJSON.id).remove();
            }
        });

        internal.bind_edit_button('.comments_list', '.comment_actions a.edit');
    });
})(jQuery);



