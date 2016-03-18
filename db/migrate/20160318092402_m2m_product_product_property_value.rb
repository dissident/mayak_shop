class M2mProductProductPropertyValue < ActiveRecord::Migration
  def change
   create_table :product_property_values_products, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :product_property_value
   end
   add_index :product_property_values_products, :product_property_value_id, name: "products_property_value_id_index"
  end
end
