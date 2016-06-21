class LineItem < ActiveRecord::Base
  belongs_to :variant
  belongs_to :cart
end
