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
                if (callbacks.error) {
                    options.error = callbacks.error;
                }

                if (callbacks.success) {
                    options.success = callbacks.success;
                }

                if (callbacks.complete) {
                    options.complete = callbacks.complete;
                }
            }

            $.ajax(options);
        });
    };

    return exports;
})(jQuery);