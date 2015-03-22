function noty_error_callback(xhr) {
    var data_elements = $('.data_elements');
    data_elements.find('.popup_message').remove();

    var new_popup = $('<div>', { class: 'popup_message', 'data-message-type': 'error', 'data-message': xhr.responseJSON.message });
    data_elements.append(new_popup);
    noty_popups_show();
}