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
  
  BREAD_LOG_CAT = {
    10 => "Bloem - Wit", 
    11 => "Bloem - 12granen", 
    12 => "Bloem - Meergranen", 
    13 => "Bloem - Andere", 
    20 => "Chocolade - Bakchocolade", 
    21 => "Chocolade - Smeltchocolade", 
    22 => "Chocolade - Andere", 
    30 => "Gedr. Fruit - Rozijnen", 
    31 => "Gedr. Fruit - Perziken", 
    32 => "Gedr. Fruit - Aardbeien", 
    33 => "Gedr. Fruit - Krieken", 
    34 => "Gedr. Fruit - Andere", 
    40 => "Gist", 
    40 => "Gist - Andere", 
    50 => "Noten - Walnoten", 
    51 => "Noten - Amandelen", 
    52 => "Noten - Cashew", 
    53 => "Noten - Hazelnoten", 
    54 => "Noten - Pinda", 
    55 => "Noten - Macadamia", 
    56 => "Noten - Andere", 
    60 => "Suiker - Fijne", 
    61 => "Suiker - Bloemsuiker", 
    62 => "Suiker - Grove", 
    63 => "Suiker - Andere", 
    70 => "Zaden - Maanzaad", 
    71 => "Zaden - Andere"
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