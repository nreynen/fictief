class ReportsController < ApplicationController
  before_filter :ensure_logged_in
  
  def bread_report
    @next_saturday = ((Date.today.end_of_week - 1) > Date.today ? (Date.today.end_of_week - 1) : (Date.today.end_of_week + 6)) - 7.days
    @next_saturday_int = (@next_saturday - Date.new(1970,1,1)).to_i - 7
    
    orders = Order.find(:all, :conditions => ["saturday_int = ?", @next_saturday_int])
    
    
    @breads_shorted = orders.inject({}) do |h, x|
      x[:order].split(";").each do |arr|
        unless arr.blank?
          id, quant = arr.split(",")
          h[id] ||= 0
          h[id] += quant.to_i
        end
      end
      h
    end.inject({}) do |h, x|
      name = Item.find(x[0]).name
      good_name = name.split(",")[0]
      h[good_name] ||= 0
      h[good_name] += x[1]
      h
    end
    
    @people = orders.inject({}) do |h, x|
      user = User.find(x[:user_id]).to_s
      x[:order].split(";").each do |arr|
        unless arr.blank?
          id, quant = arr.split(",")
          name = Item.find(id).name
          h[user] ||= {}
          h[user][name] = quant
        end
      end
      h
    end
  end
end