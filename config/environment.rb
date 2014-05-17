require File.expand_path('../application', __FILE__)

fictief::Application.configure do
  config.sass.line_comments = false
  config.sass.cache = false
  
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
  
  DAYS = {
    "Monday" => "Maandag", 
    "Tuesday" => "Dinsdag", 
    "Wednesday" => "Woensdag", 
    "Thursday" => "Donderdag", 
    "Friday" => "Vrijdag", 
    "Saturday" => "Zaterdag", 
    "Sunday" => "Zondag"
  }
  
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
  
  RIGHTS = {
    :admin => "Admin",
    :user => "User",
    :bread_user => "Bread User",
    :bread_admin => "Bread Admin",
    :f_one_user => "F1 User",
    :f_one_admin => "F1 Admin",
    :poker_user => "Poker User",
    :poker_admin => "Poker Admin",
    :book_admin => "Book Admin",
    :workday_user => "WorkCal User"
  }
end

fictief::Application.initialize!