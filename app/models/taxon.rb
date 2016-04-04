class Taxon < ActiveRecord::Base

  has_many :products, inverse_of: :taxon

  belongs_to :taxonomy, inverse_of: :taxons

  validates :name, presence: true
end
