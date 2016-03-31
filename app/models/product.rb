class Product < ActiveRecord::Base

  belongs_to :prototype, inverse_of: :products

  has_and_belongs_to_many :product_property_values

  has_many :variants, inverse_of: :product, dependent: :destroy

  accepts_nested_attributes_for :variants

  validates :name, :slug, presence: true
  validates_associated :variants


end
