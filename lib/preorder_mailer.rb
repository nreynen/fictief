class PreorderMailer
  
  # Run op woensdag.
  
  def self.engage
    puts "Initializing PreorderMailer"
    puts "Finding users with preorder"
    orders = Bread::WeeklyOrder.all
    next_sat = ((Date.today.end_of_week - 1) >= Date.today ? (Date.today.end_of_week - 1) : (Date.today.end_of_week + 6))
    
    puts "#{orders.length} orders found"
    
    orders.each do |o|
      Bread::Order.create({
        :user_id => o.user_id, 
        :order => o.order, 
        :saturday_int => next_sat
      })
    end
    
    User.find(:all, :conditions => ["id IN (?)", orders.map(&:user_id)]).each do |usr|
      puts "Mailing user #{usr.email}"
      MasterMailer.deliver_bread_alert({
        :user => usr, 
        :subject => "Bread Reminder: An automatic order was executed!", 
        :message => "Hi, #{usr.first_name}.<br>Your Weekly Order was executed. If this is a mistake, or you haven't got a weekly order, change this on the website.<br><br>Grtz from the <a href='http://yato-extreme.com'>yato-extreme</a> team."
      })
    end
    
    puts "Orders made."
    puts "Terminating PreorderMailer"
  end
end