$(window).ready(function(){
  
});

$(document).ready(function() {
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
});

function generate_overview_table() {
  var stringeske = "<table><tbody><tr><td>Item</td><td>Total&nbsp;&euro;</td></tr>";
  var total = 0;
  $(".quantity_field[value!='']").each(function(i, ob){
    var priceke = parseInt($(ob).val()) * parseFloat($(ob).attr("price"));
    total += priceke;
    stringeske += "<tr><td>" + $("#" + $(ob).attr("td_id")).html() + "</td><td style='text-align: right;'>" + $(ob).val() + " * " + parseFloat($(ob).attr("price")) + " = " + (priceke).toFixed(2) + "</td></tr>";
  });
  stringeske += "<tr><td>&nbsp;</td><td style='text-align: right;'>Total: &euro; " + (total).toFixed(2) + "</td></tr>";
  stringeske += "</tbody></table>"
  return stringeske;
}

function adjust_qtip_content() {
  var tip_api = $('#overview_hover').qtip('api');
  tip_api.updateContent(generate_overview_table(), false);
}