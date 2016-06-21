class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(variant_id)
    current_item = line_items.find_by(variant_id: variant_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(variant_id: variant_id)
    end
    current_item
  end

  def full_price
    price = 0
    if self.line_items.any?
      self.line_items.each do |item|
        item_price = item.variant.price
        if item.quantity > 1
          item_price = item_price * item.quantity
        else
          item_price
        end
        price = price + item_price
      end
    end
    price
  end

end
