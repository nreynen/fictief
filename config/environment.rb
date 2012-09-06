RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'Brussels'
  config.active_record.default_timezone = 'Brussels'
  
  MONTHS = {
    "January" => "Januari", 
    "February" => "Februari", 
    "March" => "Maart", 
    "April" => "April", 
    "May" => "Mei", 
    "June" => "Juni", 
    "July" => "Juli", 
    "August" => "Augustus", 
    "September" => "September", 
    "October" => "Oktober", 
    "November" => "November", 
    "December" => "December"
    }
  DAYS = {
    "Monday" => "Maandag", 
    "Tuesday" => "Dinsdag", 
    "Wednesday" => "Woensdag", 
    "Thursday" => "Donderdag", 
    "Friday" => "Vrijdag", 
    "Saturday" => "Zaterdag", 
    "Sunday" => "Zondag"
  }
  
  RIGHTS = {
    :admin => "Admin",
    :user => "User",
    :bread_user => "Bread User",
    :f_one_user => "F1 User",
    :poker_user => "Poker User",
    :bread_admin => "Bread Admin",
    :f_one_admin => "F1 Admin",
    :poker_admin => "Poker Admin"
  }
end

require 'will_paginate'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "yato-extreme.com",
  :authentication => :plain,
  :user_name => "noreply@yato-extreme.com",
  :password => "noreply_extreme", 
  :enable_starttls_auto => true
}