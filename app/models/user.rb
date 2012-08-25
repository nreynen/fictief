class User < ActiveRecord::Base
  validates_presence_of :login
  validates_presence_of :password
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  has_one :user_session, :dependent => :destroy
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def name
    "#{self.first_name[0, 1]}. #{self.last_name}"
  end
end