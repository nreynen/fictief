class Workday::Designation < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :name
  
  named_scope :all_sorted, {
    :order => ["name ASC"]
  }
end