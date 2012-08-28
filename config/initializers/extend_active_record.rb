# Met dank aan Kai De Sutter
module ActiveRecord
  module IntDater
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def date_to_int(date)
        if date.is_a? String
          y, m, d, *rest = date.scan(/\d+/)
          date = Date.new(y.to_i, m.to_i, d.to_i)
        end
        date = Date.new(date[:year].to_i, date[:month].to_i, date[:day].to_i) if date.is_a? Hash
        (date - Date.new(1970,1,1)).to_i unless date.nil?
      end
      
      def int_to_date(int)
        Date.new(1970,1,1) + int unless int.nil?
      end

      def int_dater(*options)
        options.each do |column|
          
          define_method("#{column}") do
            self.class.int_to_date(super)
          end
          
          define_method("#{column}=") do |*args|
            vr, *fucker = *args
            super(self.class.date_to_int(vr))
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::IntDater)