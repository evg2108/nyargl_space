//= require layouts/application
//= require_self

$(document).ready(function(){
    $('section.main_content').on('click', '.author .list_item', function() {
        location.href = $(this).find('a').attr('href');
    });
    $('section.main_content').on('click', '.author .list_item a', function(e) {
        e.stopPropagation();
    });
});