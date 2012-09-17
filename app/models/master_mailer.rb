class MasterMailer < ActionMailer::Base
  
  def bread_alert(options)
    from "Bread Alerter <noreply@yato-extreme.com>"
    recipients options[:user].email
    subject options[:subject]
    content_type "multipart/mixed"
    body :user => options[:user], :message => options[:message]
  end
end
