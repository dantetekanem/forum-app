// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function() {
  $('[data-behaviour~="edit-post"]').on('click', function() {
    var update_url = $(this).data('update-url');
    var fetch_url = $(this).data('fetch-url');

    $.getJSON(fetch_url, function(json) {
      $('#post_edit').attr('action', update_url);
      var simplemdePost = new SimpleMDE({ element: document.getElementById('post_edit_content'), autofocus: true });
      simplemdePost.value(json.content);

      $('#post_edit_modal').modal();
    })
  })
}

$(document).on('turbolinks:load', ready);
