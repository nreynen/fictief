class Bread::WeeklyOrder < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :order
  
  def to_readable
    price = 0.0
    readable = self[:order].split(";").inject([]) do |a, x|
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
  
  def total_price
    price = 0.0
    self.order.split(";").each do |x|
      price += Bread::Item.find(x.split(",").first).price * x.split(",")[1].to_i
    end
    price
  end
end