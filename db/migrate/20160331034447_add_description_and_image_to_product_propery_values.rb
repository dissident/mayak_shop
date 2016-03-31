class AddDescriptionAndImageToProductProperyValues < ActiveRecord::Migration
  def change
    add_column :product_property_values, :description, :text
    add_column :product_property_values, :image, :string
  end
end
