class Taxonomy < ActiveRecord::Base

  has_and_belongs_to_many :prototypes

  has_many :taxons, inverse_of: :taxonomy, dependent: :destroy

  accepts_nested_attributes_for :taxons, allow_destroy: true

  validates :name, presence: true
  validates_associated :taxons

  before_validation :create_latin_name

  private

  def create_latin_name
    self.latin_name = Russian::transliterate(name).parameterize.dasherize
  end

end
