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
    :admin => "Admin"
  }
end

require 'will_paginate'