[true, false].each do |c|
  c.class.class_eval do
  
    def to_img
      return "<img src='/assets/#{self}.png' style='width: 19px; height: 19px; margin: 0px; margin-bottom: -6px; opacity: 0.9;' title='#{self.to_s.capitalize}' />".html_safe
    end
    
    def to_yesno
      begin
        if !!self == self
          self ? "Yes" : "No"
        end
      rescue
        self
      end
    end
  end
end