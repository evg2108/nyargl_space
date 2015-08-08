document.remote_forms = (function($) {
    var exports = {};

    exports.init = function(parent_selector, form_class_or_id, callbacks) {
        $(parent_selector).on('submit', 'form' + form_class_or_id, function(e) {
            e.preventDefault();

            var $this = $(this);
            var options = {
                url: $this.attr('action'),
                dataType: 'JSON',
                method: $this.attr('method'),
                data: $this.serialize()
            };

            if (typeof callbacks == 'object') {
                if (callbacks.complete || callbacks.success || callbacks.error) {
                    options.complete = function(xhr, status) {
                        if (callbacks.complete) {
                            callbacks.complete(xhr, status);
                        }

                        if (status == 'success') {
                            if (callbacks.error && xhr.responseJSON.status == 'error') {
                                callbacks.error(xhr);
                            } else if (callbacks.success && status == 'success') {
                                callbacks.success(xhr);
                            }
                        } else {
                            console.log('Неожиданный ответ сервера');
                        }
                    };
                }
            }

            $.ajax(options);
        });
    };

    return exports;
})(jQuery);