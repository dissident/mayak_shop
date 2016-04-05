class Taxon < ActiveRecord::Base

  has_and_belongs_to_many :products

  belongs_to :taxonomy, inverse_of: :taxons

  validates :name, presence: true

  before_validation :create_latin_name

  private

  def create_latin_name
    self.latin_name = Russian::transliterate(name).parameterize.dasherize
  end


end
