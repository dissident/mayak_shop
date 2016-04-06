class ProductProperty < ActiveRecord::Base

  has_and_belongs_to_many :prototypes

  has_many :product_property_values, inverse_of: :product_property

  accepts_nested_attributes_for :product_property_values, allow_destroy: true

  validates :name, presence: true
  validates_associated :product_property_values

  before_validation :create_latin_name

  private

  def create_latin_name
    self.latin_name = Russian::transliterate(name).parameterize.dasherize
  end

end
