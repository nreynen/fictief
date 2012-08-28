class Order < ActiveRecord::Base
  
  belongs_to :user
  
  int_dater :saturday_int
  
  validates_presence_of :user_id
  validates_presence_of :order
  validates_presence_of :saturday_int
  
  def to_readable
    self[:order].inject([]) do |a, x|
      x.split(";").each do |arr|
        unless arr.blank?
          id, quant = arr.split(",")
          name = Item.find(id).name
          a << "#{quant} x #{name}"
        end
      end
      a
    end.join(", ")
  end
end