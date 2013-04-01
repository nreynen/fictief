class Bread::Order < ActiveRecord::Base
  
  belongs_to :user
  
  int_dater :saturday_int
  
  validates_presence_of :user_id
  validates_presence_of :order
  validates_presence_of :saturday_int
  
  def to_readable
    price = 0.0
    readable = self[:order].inject([]) do |a, x|
      x.split(";").each do |arr|
        unless arr.blank?
          id, quant = arr.split(",")
          it = Bread::Item.find(id)
          price += (quant.to_f * it.price)
          a << "#{quant} x #{it.name}"
        end
      end
      a
    end.join(", ")
    [readable, ". Yielding a total of #{price} euro"].join("")
  end
end