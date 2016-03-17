class Variant < ActiveRecord::Base

  belongs_to :product, inverse_of: :variants
end
