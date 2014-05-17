class NewsFeed < ActiveRecord::Base
  validates_presence_of :text
  
  scope :last_five, ->{order("created_at DESC").limit(5)}
end