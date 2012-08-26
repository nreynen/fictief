class Order < ActiveRecord::Base
  
  belongs_to :user
  
  int_dater :saturday_int
  
  validates_presence_of :user_id
  validates_presence_of :order
  validates_presence_of :saturday_int
end