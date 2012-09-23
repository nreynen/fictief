class User < ActiveRecord::Base
  validates_presence_of :login
  validates_presence_of :password
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  
  has_one :user_session, :dependent => :destroy
  has_many :user_rights, :dependent => :destroy
  
  has_many :orders
  
  named_scope :with_order, lambda { |sat|
    {
      :joins => "LEFT OUTER JOIN orders ON users.id = orders.user_id", :conditions => ["orders.saturday_int = ?", sat]
    }
  }
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def name
    "#{self.first_name[0, 1]}. #{self.last_name}"
  end
  
  def has_rights_for?(keys)
    self.user_rights.map(&:rights_key).inject(false){|b, x| b ? b : keys.include?(x)}
  end
  
  def to_s
    "#{self.first_name} #{self.last_name}"
  end
end