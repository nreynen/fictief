class ReminderMailer
  
  def self.engage
    puts "Initializing ReminderMailer"
    puts "Finding users without order"
    users = User.without_order
    
    puts "#{users.length} shoppers found"
    
    selection = ExportSelection.find(DB_MAPPING[:never_activated_selection_id]).parameters
    skeleton = MailmergeSkel.find(DB_MAPPING[:never_activated_skel_id])
    
    reminder_ids = shoppers.inject([]) do |a, s|
      a << (s.neveractivated_shopper_reminder || s.create_neveractivated_shopper_reminder)
      a
    end.map(&:id)
    NeveractivatedShopperReminder.update_all("count = count + 1", ["id IN (?)", reminder_ids]) unless reminder_ids.empty?
    
    puts "Reminders made"
    
    mailmerge = admin.mailmerges.create(({
      :atlas => true,
      :subject => skeleton.subject,
      :text => skeleton.text,
      :tip => skeleton.tip,
      :noreply => true,
      :priority => skeleton.priority
    }).merge({
      :name => "",
      :status => "Queueing...",
      :parameters => {
        :ids => shopper_ids.join(","),
        :questions => selection,
        :type => "mmerge"
      }
    }))
    mailmerge.add_shoppers(shopper_ids)
    mailmerge.update_attribute(:worker_id, "Creating...")
    MailmergeWorker.async_do_mailmerge(:id => mailmerge.id).split(":").last
    
    puts "Mails sent."
    puts "Terminating ActivationMailer"
  end
end