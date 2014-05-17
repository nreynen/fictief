module ApplicationHelper
  
  def link_to_with_highlighting(name, url, url_options, html_options)
    link_to(name.gsub(" ", "&nbsp;").html_safe, url, url_options.merge(html_options))
  end
  
  def generate_notice(notice)
    return_string = ""
    
    if notice[:notice]
      return_string << "<div class='notice' onclick='$(this).hide();'><img height='45' width='45' src='/assets/notice.png'>"
      return_string << "<p>#{notice[:notice]}</p></div>"
    elsif notice[:error]
      return_string << "<div class='error' onclick='$(this).hide();'><img height='45' width='45' src='/assets/error.png'>"
      return_string << "<p>#{notice[:error]}</p></div>"
    elsif notice[:success]
      return_string << "<div class='success' onclick='$(this).hide();'><img height='45' width='45' src='/assets/success.png'>"
      return_string << "<p>#{notice[:success]}</p></div>"
    end
    
    return_string.html_safe
  end
  
  def dutchify_date(date_string)
    the_date = date_string
    DAYS.each_pair do |key, day|
      the_date = the_date.gsub(key, day)
    end
    MONTHS.each_pair do |key, month|
      the_date = the_date.gsub(key, month)
    end
    the_date
  end
  
  def loader
    image_tag "load.gif", :id => "loader", :style => "width: 150px; float: right; margin-right: -9px; margin-top: -5px; display: none;"
  end
  
  # Dank u, Kai De Sutter
  def put(identifier)
    static = Static.find_by_identifier identifier
    static = Static.create({:identifier => identifier, :text => "*#{identifier}*"}) if static.nil?
    static.text
  end
  
  # Dank u, Kai De Sutter
  def shorten(text, chars=20)
    text.length > chars ? "#{text[0..chars-3]}..." : text
  end
  
  def price(price)
    sprintf("%.2f &euro;", price.to_s).html_safe
  end
  
  def niceify_bool(bool)
    image_tag "status/#{bool.to_s}.gif", :style => "width: 13px; height: 13px; opacity: 0.7;", :title => "#{bool.to_s.capitalize}"
  end
  
  def new_link(_options={})
    options = {
      :text => _options[:text] || put("link_new")
    }.merge(_options)
    generate_link options
  end
  
  def show_link(_options={})
    options = {
      :text => _options[:text] || image_tag("/assets/magnify.png", {:style => "width: 19px; height: 19px; margin: 0px; margin-bottom: -6px;"}) #put("link_show")
    }.merge(_options)
    generate_link options
  end
  
  def edit_link(_options={})
    options = {
      :text => _options[:text] || image_tag("/assets/edit.png", {:style => "width: 19px; height: 19px; margin: 0px; margin-bottom: -6px;"}) #put("link_edit")
    }.merge(_options)
    generate_link options
  end
  
  def destroy_link(_options={})
    options = {
      :text => _options[:text] || image_tag("/assets/bin.png", {:style => "width: 19px; height: 19px; margin: 0px; margin-bottom: -6px;"}), #put("link_destroy"), 
      :attrs => _options[:attrs] || {}
    }.merge(_options)
    options[:attrs].merge!({:confirm => put("are_you_sure"), :method => :delete})
    generate_link options
  end
  
  def back_link(_options={})
    options = {
      :text => _options[:text] || put("link_back")
    }.merge(_options)
    generate_link options
  end
  
  private
  
  def generate_link(_options = {})
    begin
      options = {
        :url => _options[:url] || "", 
        :text => _options[:text] || "", 
        :style => _options[:style] || "", 
        :class => _options[:class] || "", 
        :attrs => _options[:attrs] || {}
      }
      
      raise Exception, "No URL was given..." if options[:url].blank?
      
      link_to options[:text].html_safe, options[:url], options[:attrs].merge!({:style => options[:style]})
    rescue Exception => e
      link_to options[:text].html_safe, error_root_path(:message => {:error => e.message}), options[:attrs].merge({:style => options[:style]})
    end
  end
end
