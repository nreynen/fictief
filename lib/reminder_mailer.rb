class ReminderMailer
  
  # Run op donderdag.
  
  def self.engage
    puts "Initializing ReminderMailer"
    puts "Finding users without order"
    now = Date.today
    sat = ((Date.today.end_of_week - 1) >= Date.today ? (Date.today.end_of_week - 1) : (Date.today.end_of_week + 6)) #now + ((5 - now.wday) % 7)
    sat_int = (sat - Date.new(1970,1,1)).to_i
    users = User.all.map(&:id)
    users_with = User.with_order(sat_int).find(:all, :select => "users.id").map(&:id)
    users_without = users - users_with
    
    puts "#{users_without.length} shoppers found"
    
    User.find(:all, :conditions => ["id IN (?)", users_without]).each do |usr|
      puts "Mailing user #{usr.email}"
      MasterMailer.bread_alert({
        :user => usr, 
        :subject => "Bread Reminder: You haven't created an order!", 
        :message => "Hi, #{usr.first_name}.<br>You haven't created an order for this week. If you want, you can still order until Saturday at 06:00.<br><br>Grtz from the <a href='http://yato-extreme.com'>yato-extreme</a> team."
      }).deliver
    end
    
    puts "Mails sent."
    puts "Terminating ReminderMailer"
  end
end