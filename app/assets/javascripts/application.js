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
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function () {
  var id = window.location.pathname.split('/')[1];

  $('.links').delegate('#makeUnread', 'click', function () {
    var $link = $(this).closest('#link');
    var statusButton = $link.find('#makeUnread');
    var linkParams = {link: {status: true}};

    $.ajax({
      type: 'PATCH',
      url: '/' + id + '/links/' + $link.find('a').attr('data-id') + '/read',
      data: linkParams,
      success: function () {
        statusButton[0].innerHTML = "Make Read";
        statusButton.attr('id', 'makeRead');
        $link.find('a').removeClass('unread').addClass('read');
      }
    });
  })

    .delegate('#makeRead', 'click', function () {
      console.log('click');
      var $link = $(this).closest('#link');
      var statusButton = $link.find('#makeRead');
      var linkParams = {link: {status: false}};

      $.ajax({
        type: 'PATCH',
        url: '/' + id + '/links/' + $link.find('a').attr('data-id') + '/unread',
        data: linkParams,
        success: function () {
          statusButton[0].innerHTML = "Make Unread";
          statusButton.attr('id', 'makeUnread');
          $link.find('a').removeClass('read').addClass('unread');
        }
      });
    });
});

$(document).ready(function () {
  $("#filter").keyup(function () {

    // Retrieve the input field text and reset the count to zero
    var filter = $(this).val(), count = 0;

    // Loop through the comment list
    $(".links li").each(function () {

      // If the list item does not contain the text phrase fade it out
      if ($(this).text().search(new RegExp(filter, "i")) < 0) {
        $(this).fadeOut();

        // Show the list item if the phrase matches and increase the count by 1
      } else {
        $(this).show();
        count++;
      }
    });

    // Update the count
    var numberItems = count;
    $("#filter-count").text("Number of Links = " + count);
  });

  $('#filters a').click(function (e) {

    e.preventDefault();

    var filter = $(this).attr('id');

    if (filter == "sort") {

      $('#box ul li').sort(asc_sort).appendTo('#filter');
    }
    else {

      $('#box ul li').show();
      $('#box ul li:not(.' + filter + ')').hide();

    }
  });

  function asc_sort(a, b) {
    return ($(b).text()) < ($(a).text());
  }

  $('#nameSort').click(function (e) {
    e.preventDefault();

    var links = $('.links li').get();
    links.sort(function (a, b) {
      var keyA = $(a).text();
      var keyB = $(b).text();

      if (keyA < keyB) return -1;
      if (keyA > keyB) return 1;
      return 0;
    });
    var ul = $('#linksLinksLinks');
    $.each(links, function (i, li) {
      ul.append(li);
    });
  });

  $('#statusSort').click(function (e) {
    e.preventDefault();

    var links = $('.links li').get();
    links.sort(function (a, b) {
      var keyA = $(a).children()[1].id;
      var keyB = $(b).children()[1].id;

      if (keyA < keyB) return -1;
      if (keyA > keyB) return 1;
      return 0;
    });
    var ul = $('#linksLinksLinks');
    $.each(links, function (i, li) {
      ul.append(li);
    });
  });
});

