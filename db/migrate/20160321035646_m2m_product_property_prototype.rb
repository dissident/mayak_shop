class M2mProductPropertyPrototype < ActiveRecord::Migration
  def change
   create_table :product_properties_prototypes, id: false do |t|
      t.belongs_to :product_property, index: true
      t.belongs_to :prototype, index: true
    end
  end
end
