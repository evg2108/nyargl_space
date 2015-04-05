//= require layouts/application
//= require inputs/toggle_button_input
//= require shared/application/noty_error_callback.js
//= require_self

function _error_callback(xhr) {
    noty_error_callback(xhr.responseJSON.message);
}

$(document).ready(function() {
    initToggleButtons(_error_callback);
});