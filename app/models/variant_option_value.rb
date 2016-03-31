class VariantOptionValue < ActiveRecord::Base

  has_and_belongs_to_many :variants

  belongs_to :variant_option, inverse_of: :variant_option_values

  validates :value, presence: true

  mount_uploader :image, VariantOptionValueUploader

end
