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
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

var startMDE = function() {
  if ($('.simple-mde').length) {
    var simplemdeTopic = new SimpleMDE({ element: document.getElementById('topic_content') });
    var simplemdePost = new SimpleMDE({ element: document.getElementById('post_content') });
  }
}

var loadTextcomplete = function() {
  $('textarea').textcomplete([
    { // mention strategy
      match: /(^|\s)@(\w*)$/,
      search: function (term, callback) {
        console.log("search", term);
        $.getJSON('/users/search', { query: term })
          .done(function (resp) { callback(resp); })
          .fail(function ()     { callback([]);   });
      },
      replace: function (value) {
        return '$1@' + value + ' ';
      }
    }
  ], { maxCount: 20, debounce: 500 });
}

var ready = function() {
  startMDE();
  loadTextcomplete();
}

$(document).on('turbolinks:load', ready);
