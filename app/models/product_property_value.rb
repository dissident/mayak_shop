class ProductPropertyValue < ActiveRecord::Base

  has_and_belongs_to_many :products

  belongs_to :product_property, inverse_of: :product_property_values

  validates :value, presence: true

  mount_uploader :image, ProductPropertyValueUploader



end
