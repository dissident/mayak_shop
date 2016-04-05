class M2mProductTaxon < ActiveRecord::Migration
  def change
   create_table :products_taxons, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :taxon, index: true
    end
  end
end
