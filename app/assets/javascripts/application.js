//= require jquery-2.1.0.min
//= require rails
//= require jquery.qtip.min

ready = function() {
  resize_divkes();
  
  $('#overview_hover').qtip({
    style: { name: 'cream', tip: true }, 
    position: {
      corner: {
         target: 'topMiddle',
         tooltip: 'bottomMiddle'
      }
    }, 
    content: {
      text: generate_overview_table(), 
      prerender: true
    }
  });
};
$(window).resize(function() {
  resize_divkes();
});

function adjust_qtip_content() {
  var tip_api = $('#overview_hover').qtip('option', 'content.text', generate_overview_table());
}

function decrement_item(item_id) {
  var val = parseInt($("#item_show_" + item_id).html());
  if (val != 0) {
    $("#item_show_" + item_id).html(val - 1);
    $("#items_" + item_id).val(val - 1);
    adjust_qtip_content();
  }
}

function generate_overview_table() {
  var stringeske = "<table><tbody><tr><td>Item</td><td>Total&nbsp;&euro;</td></tr>";
  var total = 0;
  $(".quantity_field").each(function(i, ob){
    var priceke = parseInt($(ob).html()) * parseFloat($(ob).attr("price"));
    if (priceke > 0) {
      total += priceke;
      stringeske += "<tr><td>" + $(".cell_" + $(ob).attr("td_id")).html() + "</td><td style='text-align: right;'>" + $(ob).html() + " * " + parseFloat($(ob).attr("price")) + " = " + (priceke).toFixed(2) + "</td></tr>";
    }
  });
  stringeske += "<tr><td>&nbsp;</td><td style='text-align: right;'>Total: &euro; " + (total).toFixed(2) + "</td></tr>";
  stringeske += "</tbody></table>"
  return stringeske;
}

function increment_item(item_id) {
  var val = parseInt($("#item_show_" + item_id).html());
  $("#item_show_" + item_id).html(val + 1);
  $("#items_" + item_id).val(val + 1);
  adjust_qtip_content();
}

function login_user() {
  alert("Logged in: " + $("#username").val() + " with: " +$("#password").val());
}

function resize_divkes(){
  $("#main_page").css("height", (parseInt($(window).height()) - 1));
  $("#main_content").css("min-height", (parseInt($("#main_page").height()) - parseInt($("#main_banner").height()) - parseInt($("#main_menu").height()) - parseInt($("#main_footer").height()) - 25));
  $("#main_content").css("max-height", (parseInt($("#main_page").height()) - parseInt($("#main_banner").height()) - parseInt($("#main_menu").height()) - parseInt($("#main_footer").height()) - 25));
  $("#lipsum_block").css("min-height", (parseInt($("#main_content").height())));
  $("#lipsum_block").css("height", (parseInt($("#main_content").height())));
}

$(document).ready(ready);
$(document).on('page:load', ready);