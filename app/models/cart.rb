class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def full_price
    price = 0
    if self.line_items.any?
      self.line_items.each do |item|
        price = price + item.variant.price
      end
    else
      price
    end
    price
  end

end
