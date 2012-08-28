class MasterMailer < ActionMailer::Base
  
  def bread_alert(options)
    from "Bread Alerter <noreply@yato-extreme.com>"
    recipients options[:user].email
    subject options[:subject]
    body :user => options[:user], :message => options[:message]
  end
end
