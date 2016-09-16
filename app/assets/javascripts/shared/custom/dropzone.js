//= require vendor/dropzone
//= require_self

document.dropzone = (function($) {
    Dropzone.autoDiscover = false;

    var exports = { dropzones: {} };

    var init_options = function(options) {
        var default_options = {
            dictDefaultMessage: 'Перетащите фотографии сюда или щёлкните мышью'
        };

        if (options) {
            var option_keys = Object.keys(options);
            for (var i = 0; i < option_keys.length; i++) {
                default_options[option_keys[i]] = options[option_keys[i]];
            }
        }

        return default_options;
    };

    exports.init = function(dropzone_id, extra_options) {
        var options = init_options(extra_options);

        var $dropzone_element = $('#' + dropzone_id);
        $dropzone_element.show();

        exports.dropzones[dropzone_id] = $dropzone_element.dropzone(options);
    };

    return exports;
})(jQuery);