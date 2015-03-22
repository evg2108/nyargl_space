//= require layouts/application
//= require inputs/toggle_button_input
//= require shared/application/noty_error_callback.js
//= require_self

$(document).ready(function() {
    initToggleButtons(noty_error_callback);
});