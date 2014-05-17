module ActiveRecord
  module IntDater
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def date_to_int(date)
        date = DateTime.new(date[:year].to_i, date[:month].to_i, date[:day].to_i) if date.is_a? Hash
        date = DateTime.new(date.gsub("-", "/").split("/")[0].to_i, date.gsub("-", "/").split("/")[1].to_i, date.gsub("-", "/").split("/")[2].to_i) if date.is_a? String
        (date - DateTime.new(1970,1,1)).to_i unless date.nil? || date.is_a?(Integer)
      end
      
      def int_to_date(int)
        DateTime.new(1970,1,1) + int unless int.nil?
      end

      def int_dater(*options)
        options.each do |column|
          define_method("#{column}") do
            self.class.int_to_date(self[column.to_sym])
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