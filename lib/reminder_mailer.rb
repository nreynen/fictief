class ReminderMailer
  
  # Run op donderdag.
  
  def self.engage
    puts "Initializing ReminderMailer"
    puts "Finding users without order"
    now = Date.today
    sat = now + ((5 - now.wday) % 7)
    users = User.all.map(&:id)
    users_with = User.with_order(sat).find(:all, :select => "users.id")
    users_without = users - users_with
    users_without = [User.find_by_first_name("Nico")]
    puts "#{users_without.length} shoppers found"
    
    User.find(:all, :conditions => ["id IN (?)", users_without]).each do |usr|
      MasterMailer.deliver_bread_alert({
        :user => usr, 
        :subject => "Bread Reminder: You haven't created an order!", 
        :message => "You haven't created an order for this week. If you want, you can still order untill Friday at 21:00."
      })
    end
    
    puts "Mails sent."
    puts "Terminating ReminderMailer"
  end
end