class Taxonomy < ActiveRecord::Base

  has_many :taxons, inverse_of: :taxonomy, dependent: :destroy

  accepts_nested_attributes_for :taxons, allow_destroy: true

  validates :name, presence: true
  validates_associated :taxons

end
