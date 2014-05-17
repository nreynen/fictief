class Static < ActiveRecord::Base
  validates_presence_of :identifier
  validates_presence_of :text
end