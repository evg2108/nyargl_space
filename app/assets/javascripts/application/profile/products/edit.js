//= require layouts/application
//= require shared/custom/dropzone
//= require_self

$(document).ready(function() {
    document.dropzone.init('product_pictures_upload_form_dropzone', { paramName: 'product[pictures]', uploadMultiple: true, parallelUploads: 5 });
});