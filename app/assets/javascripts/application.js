// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.purr
//= require best_in_place
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function () {
  var id = window.location.pathname.split('/')[1];

  $('.links').delegate('#makeUnread', 'click', function () {
    var $link = $(this).closest('#link');
    var statusButton = $link.find('#makeUnread');
    var linkParams = { link: {status: true} };

    $.ajax({
      type: 'PATCH',
      url: '/' + id + '/links/' + $link.find('a').attr('data-id') + '/read',
      data: linkParams,
      success: function () {
        statusButton[0].innerHTML = "Make Read";
        statusButton.attr('id','makeRead');
        $link.find('a').removeClass('unread').addClass('read');
      }
    });
  })

    .delegate('#makeRead', 'click', function () {
    console.log('click');
    var $link = $(this).closest('#link');
    var statusButton = $link.find('#makeRead');
    var linkParams = { link: {status: false} };

    $.ajax({
      type: 'PATCH',
      url: '/' + id + '/links/' + $link.find('a').attr('data-id') + '/unread',
      data: linkParams,
      success: function () {
        statusButton[0].innerHTML = "Make Unread";
        statusButton.attr('id','makeUnread');
        $link.find('a').removeClass('read').addClass('unread');
      }
    });
  });
});
