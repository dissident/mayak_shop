class Product < ActiveRecord::Base
  has_and_belongs_to_many :product_property_values

  has_many :variants, inverse_of: :product, dependent: :destroy

  accepts_nested_attributes_for :variants

  validates :name, :slug, presence: true


end
