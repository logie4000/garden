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
//= require dropzone
//= require Chart.bundle
//= require chartkick
// require_tree .
//

Dropzone.autoDiscover = false;
Dropzone.maxFilesize = 5;

function addDropzoneById(dropUrl, dropElementId, targetElementId, withThumbnail, dropParams) {
  if (document.getElementById(dropElementId)) {
    console.log("Adding dropzone to element: " + dropElementId + " with url '" + dropUrl + "'");

    var myDropzone = new Dropzone("#" + dropElementId, {
      url: dropUrl,
      uploadMultiple: false,
      paramName: 'file',
      maxFilesize: 5,
      addRemoveLinks: true,
      params: dropParams,
      init: function() {
        this.on('success', function(file, response) {
          console.log("Response: " + JSON.stringify(response));
          console.log("Success for " + file.name + ": " + response.file['thumb']['url']);

          var imageBucket = document.getElementById(targetElementId);
          if (imageBucket != null && response != null) {
            var origHtml = imageBucket.innerHTML;
            var newImgUrl = response.file['normal']['url'];
            if (withThumbnail) {
              newImgUrl = response.file['thumb']['url'];
            }

            imageBucket.innerHTML = origHtml + "&nbsp;<img src='/garden_planner/" + newImgUrl + "'>";
          }
        });

        this.on('removedfile', function(file) {
          if (file.xhr) {
            return $.ajax({
              url: "" + ($("#" + dropElementId).attr("action")) + "/" + (JSON.parse(file.xhr.response).id),
              type: 'DELETE'
            });
          } else {
            var imageBucket = document.getElementById(targetElementId);
            if (imageBucket != null) {
              imageBucket.innerHTML = "IMAGE DELETED WITHOUT XHR: " + file.name;
            }
          }
        });
      }
    });
  } else {
    console.log("Element '" + dropElementId + "' does not exist!");
  }
}

function addPortraitDropzoneById(dropUrl, dropElementId, dropParams, setPortraitUrl, asThumb) {
  if (document.getElementById(dropElementId)) {
    console.log("Adding portrait dropzone to element: " + dropElementId + " with url '" + dropUrl + "'");

    var myDropzone = new Dropzone("#" + dropElementId, {
      url: dropUrl,
      uploadMultiple: false,
      paramName: 'file',
      maxFilesize: 5,
      addRemoveLinks: true,
      params: dropParams,
      init: function() {
        this.on('success', function(file, response) {
          console.log("Response: " + JSON.stringify(response));
          console.log("Success for " + file.name + ": " + response.file['thumb']['url']);

          var imageBucket = document.getElementById(dropElementId);
          if (imageBucket != null && response != null) {
            var origHtml = imageBucket.innerHTML;
            var newImgUrl = response.file['normal']['url'];
           if (asThumb) {
             newImgUrl = response.file['thumb']['url'];
           }

           var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

            return $.ajax({
              url: "" + setPortraitUrl,
              dataType:'text',
              data: "image_id=" + response.id + "&authenticity_token=" + AUTH_TOKEN,
              type: 'PATCH'
            });
          }
        });

        this.on('removedfile', function(file) {
          if (file.xhr) {
            return $.ajax({
              url: "" + ($("#" + dropElementId).attr("action")) + "/" + (JSON.parse(file.xhr.response).id),
              type: 'DELETE'
            });
          } else {
            var imageBucket = document.getElementById(targetElementId);
            if (imageBucket != null) {
              imageBucket.innerHTML = "IMAGE DELETED WITHOUT XHR: " + file.name;
            }
          }
        });
      }
    });
  } else {
    console.log("Element '" + dropElementId + "' does not exist!");
  }
}

function swap_img(id, url) {
  console.log("Swapping image at id '" + id + "' with url '" + url + "'...");
  if (document.images) {
    document.images[id].src = url;
  }
}

