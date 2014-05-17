class User < ActiveRecord::Base
  has_one :user_session, :dependent => :destroy
  has_many :orders, :dependent => :destroy, :foreign_key => "user_id", :class_name => "Bread::Order"
  has_many :user_rights, :dependent => :destroy
  #has_many :workday_designations, :dependent => :destroy, :foreign_key => "user_id", :class_name => "Workday::Designation"
  #has_many :workday_sequences, :dependent => :destroy, :foreign_key => "user_id", :class_name => "Workday::Sequence"
  #has_many :workday_workdays, :dependent => :destroy, :foreign_key => "user_id", :class_name => "Workday::Workday"
  
  serialize :pref, Hash
  
  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :login
  validates_presence_of :password
  
  scope :with_order, ->(sat){joins("LEFT OUTER JOIN orders ON users.id = orders.user_id").where("orders.saturday_int = ?", sat)}
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def has_rights_for?(keys)
    self.user_rights.map(&:rights_key).inject(false){|b, x| b ? b : keys.include?(x)}
  end
  
  def name
    "#{self.first_name[0, 1]}. #{self.last_name}"
  end
  
  def to_s
    "#{self.first_name} #{self.last_name}"
  end
end