$(document).ready(function() {
  resize_divs();
});
$(window).resize(function() {
  resize_divs();
});

function follow_link(text) {
  var url = "";
  var data = {register: "0"};
  
  if (text == "Login") {
    url = login_dnu_overviews_path;
  } else {
    url = register_dnu_overviews_path;
  }
  
  if ($("#register_first_name").length > 0) {
    var first_name = $("#register_first_name").val();
    var last_name = $("#register_last_name").val();
    var email = $("#register_email").val();
    var login = $("#register_login").val();
    var password = $("#register_password").val();
    var password_confirmation = $("#register_password_confirmation").val();
    
    data = {
      register: "1", 
      user: {
        first_name: first_name, 
        last_name: last_name, 
        email: email, 
        login: login, 
        password: password, 
        password_confirmation: password_confirmation
      }
    };
  }
  
  $.ajax({
    url: url, 
    type: "post", 
    data: data, 
    complete: function() {
      
    }, 
    success: function(data) {
      if (data.error) {
        $("#home_page_wrp_down").html(data.error);
      } else if (data.ok) {
        if (data.ok == "1") {
          alert("Success");
        } else if (data.ok == "2") {
          $(".main_title").after("<p class='error'>" + data.fail + "</p>");
        } else {
          $(".register_input input").css("border-color", "#EEEEEE");
          $.each(data.fail, function(i, x){
            $("#register_" + x).css("border-color", "red");
          });
        }
      } else {
        $("#home_page_wrp_down").html(data.data);
        resize_divs();
      }
    }, 
    error: function(a, b, c) {
      
    }
  });
}

function hide_loader() {
  $("#loader").hide();
}

function resize_divs() {
  $(".side_div, .main_div").css("min-height", window.innerHeight + "px");
  $(".side_div").css("width", ((($("#home_page_wrp_down").width() - 900) / 2) - 1) + "px");
}

function show_loader() {
  $("#loader").show();
}
