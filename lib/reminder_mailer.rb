class ReminderMailer
  
  # Run op donderdag.
  
  def self.engage
    puts "Initializing ReminderMailer"
    puts "Finding users without order"
    sat = ((Date.today.end_of_week - 1) > Date.today ? (Date.today.end_of_week - 1) : (Date.today.end_of_week + 6))
    users = User.map(&:id)
    users_with = User.with_order(sat).find(:select => "id")
    users_without = users - users_with
    users_without = User.find_by_first_name("Nico")
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