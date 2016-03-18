class Variant < ActiveRecord::Base

  has_and_belongs_to_many :variant_option_values

  belongs_to :product, inverse_of: :variants

end
