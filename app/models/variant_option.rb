class VariantOption < ActiveRecord::Base

  has_and_belongs_to_many :prototypes

  has_many :variant_option_values, inverse_of: :variant_option

  accepts_nested_attributes_for :variant_option_values, allow_destroy: true

  validates :name, presence: true
  validates_associated :variant_option_values

  before_validation :create_latin_name

  private

  def create_latin_name
    self.latin_name = Russian::transliterate(name).parameterize.dasherize
  end

end
