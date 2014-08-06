class Language < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :iso
  
  scope :ordered_by_name, ->{order("name ASC")}
end