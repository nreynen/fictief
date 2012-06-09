$(document).ready(function() {
  load_menu_resizer();
});

function load_menu_resizer() {
  $(window).resize(function() {
    resize_menu();
  });
  resize_menu();
}

/* Dank u, Kai De Sutter */
function resize_menu() {
  $("ul#menu").show();
  var win_width = $(window).width();
  var menu_items = ["ul#menu"];
  
  $(".spacer").width(0);
  $(".spacer").width($(window).outerWidth() - $("#menu").width() - 1);
}

function show_loader() {
  $("#loader").show();
}

function hide_loader() {
  $("#loader").hide();
}
