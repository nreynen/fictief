[Date, Time, NilClass].each do |clss|
  clss.class_eval do
    def in_our_time(type = :time_hour, _options = {})
      default_mapping = {
        :time => "%e %b %Y", 
        :hour => "%H:%M:%S", 
        :time_hour => "%e %b %Y %H:%M:%S"
      }
      
      options = {
        :mapping => _options[:mapping] || default_mapping[type], 
        :rescueer => _options[:rescueer] || "-"
      }
      self.strftime(options[:mapping]) rescue options[:rescueer]
    end
  end
end