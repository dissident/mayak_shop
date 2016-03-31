class AddImageToVariantOptionvalue < ActiveRecord::Migration
  def change
    add_column :variant_option_values, :image, :string
  end
end
