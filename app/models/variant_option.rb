class VariantOption < ActiveRecord::Base

  has_many :variant_option_values, inverse_of: :variant_option

  accepts_nested_attributes_for :variant_option_values, allow_destroy: true

  validates :name, presence: true
  validates_associated :variant_option_values

end
