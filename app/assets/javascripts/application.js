// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
// require dropzone
// require_tree .
//

Dropzone.autoDiscover = false;

var myDropzone = new Dropzone("#picture-dropzone",{
  uploadMultiple: false,
  paramName: "file",
  maxFilesize: 1,
  addRemoveLinks: true,
  init: function() {
    this.on('success', function(file, response) {
      console.log("Response: " + JSON.stringify(response));
      console.log("Success for " + file.name + ": " + response.file['thumb']['url']);

      var imageBucket = document.getElementById("image_bucket");
      if (imageBucket != null && response != null) {
        var origHtml = imageBucket.innerHTML;
        imageBucket.innerHTML = origHtml + "&nbsp;<img src='/garden_planner/" + response.file['thumb']['url'] + "'>";
      }
    });

    this.on('removedfile', function(file) {
      if (file.xhr) {
        return $.ajax({
          url: "" + ($("#picture-dropzone").attr("action")) + "/" + (JSON.parse(file.xhr.response).id),
          type: 'DELETE'
        });
      } else {
        var imageBucket = document.getElementById("image_bucket");
        if (imageBucket != null) {
          imageBucket.innerHTML = "IMAGE DELETED WITHOUT XHR: " + file.name;
        }
      }
    });
  }
});

