class MasterMailer < ActionMailer::Base
  default from: 'Bread Alerter <noreply@yato-extreme.com>'
  layout "bread_alert"
  
  def bread_alert(options)
    @user = options[:user]
    
    if options[:attachment] && options[:attachment_name] && options[:attachment_file_type]
      attachments[options[:attachment_name]] = File.read(options[:attachment])
    end
    
    mail(
      to: options[:user].email, 
      subject: options[:subject]
    )
  end
end
