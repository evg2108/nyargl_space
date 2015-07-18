document.remote_forms = (function($) {
    var exports = {};

    exports.init = function(form_class_or_id, callbacks) {
        var $form = $('form' + form_class_or_id + '[data-remote="true"]');
        if ($form.length > 0 && typeof callbacks == 'object') {
            if (callbacks.error) {
                $form.on('ajax:error', callbacks.error);
            }

            if (callbacks.success) {
                $form.on('ajax:success', callbacks.success);
            }

            if (callbacks.complete) {
                $form.on('ajax:complete', callbacks.complete);
            }
        }

        return $form;
    };

    return exports;
})(jQuery);