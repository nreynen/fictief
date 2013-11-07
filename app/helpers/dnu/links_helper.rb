module Dnu::LinksHelper
  
  def login_link
    main_link("Login", "dnu/element_dark.png")
  end
  
  def main_link(text, image)
    content_tag(:div, {:class => "main_link", :onclick => "follow_link('#{text}');"}) do
      [
        image_tag(image, :style => "width: 25px; height: 25px; margin-right: 2px;"), 
        text
      ].join
    end
  end
  
  def register_input_text(text, name)
    content_tag(:div, {:class => "register_input"}) do
      [
        content_tag(:span, text), 
        text_field_tag("register[#{name}]", "", :style => "width: 280px; position: relative; top: -8px;")
      ].join
    end
  end
  
  def register_input_password(text, name)
    content_tag(:div, {:class => "register_input"}) do
      [
        content_tag(:span, text), 
        password_field_tag("register[#{name}]", "", :style => "width: 280px; position: relative; top: -8px;")
      ].join
    end
  end
  
  def register_link
    main_link("Register", "dnu/element_fire.png")
  end
end