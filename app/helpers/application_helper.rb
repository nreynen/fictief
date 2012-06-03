module ApplicationHelper
  
  def link_to_with_highlighting(name, url, url_options, html_options)
    link_to(name, url, url_options.merge(html_options))
  end
  
  def generate_notice(notice)
    return_string = ""
    
    if notice[:notice]
      return_string << "<div class='notice'><img height='45' width='45' src='/images/notice.png'>"
      return_string << "<p>#{notice[:notice]}</p></div>"
    elsif notice[:error]
      return_string << "<div class='error'><img height='45' width='45' src='/images/error.png'>"
      return_string << "<p>#{notice[:error]}</p></div>"
    elsif notice[:success]
      return_string << "<div class='success'><img height='45' width='45' src='/images/success.png'>"
      return_string << "<p>#{notice[:success]}</p></div>"
    end
    
    return_string
  end
  
  def generate_newsfeed_items
    return_html = "<div class='feeds'>"
    the_feeds = generate_feed_hash(Newsfeed.last_twenty)
    @feeler.each do |date|
      return_html << "<div class='feed'>"
      return_html << "<div class='date'>#{date}</div>"
      the_feeds[date].each do |feed|
        return_html << "<div class='feed_comment'>"
        return_html << "#{feed}<br>"
        return_html << "</div>"
      end
      return_html << "</div>"
    end
    return_html << "</div>"
    return_html
  end
  
  def generate_feed_hash(feeds)
    return_hash = {}
    @feeler = []
    feeds.each do |feed|
      the_date = dutchify_date feed.created_at.strftime("%d %B %Y (%A)")
      @feeler << the_date unless @feeler.include? the_date
      return_hash[the_date] ||= []
      return_hash[the_date] << "#{feed.created_at.strftime('%H:%M:%S')} - #{feed.feed}"
    end
    return_hash
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
end