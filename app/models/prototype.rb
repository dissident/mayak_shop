class Prototype < ActiveRecord::Base
  has_and_belongs_to_many :taxonomies

  has_many :products, inverse_of: :prototype, dependent: :nullify

  has_and_belongs_to_many :variant_options
  has_and_belongs_to_many :product_properties

  validates :name, presence: true

end
