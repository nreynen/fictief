class MasterMailer < ActionMailer::Base
  
  layout "bread_alert"
  
  def bread_alert(options)
    from "Bread Alerter <noreply@yato-extreme.com>"
    recipients options[:user].email
    subject options[:subject]
    content_type "multipart/mixed"
    
    part "multipart/related" do |m|e
      m.part "multipart/alternative" do |a|
        a.part "text/plain" do |y|
          y.body = options[:message].unhtml
          y.transfer_encoding = "base64"
        end
        a.part "text/html" do |y|
          y.body = options[:message]
        end
      end
    end
    
    if options[:attachment] && options[:attachment_name] && options[:attachment_file_type]
      attachment :content_type => options[:attachment_file_type], :body => File.read(options[:attachment]), :filename => options[:attachment_name]
    end
  end
end
