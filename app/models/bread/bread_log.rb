class Bread::BreadLog < ActiveRecord::Base
  
  int_dater :event_date
  
  validates_presence_of :cat_id
  validates_presence_of :event_date
  validates_presence_of :price
end