// This is a manifest file contains declaration requirements of scripts, that used on all pages
// for "application" layout.
//
// This file must be required on any js file for "application" layout
//
//= require jquery.js
//= require jquery_ujs
//= require bootstrap-sprockets
//= require vendor/noty/jquery.noty.packaged.min
//= require shared/application/noty_popups
//= require_self

$(document).ready(function() {
    noty_popups_show();

    $('#collapsed_menu').removeClass('in'); // if JS allowed

    $('body').tooltip({selector: '[data-toggle="tooltip"]'});
});