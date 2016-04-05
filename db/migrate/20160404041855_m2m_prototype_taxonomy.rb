class M2mPrototypeTaxonomy < ActiveRecord::Migration
  def change
   create_table :prototypes_taxonomies, id: false do |t|
      t.belongs_to :prototype, index: true
      t.belongs_to :taxonomy, index: true
    end
  end
end
