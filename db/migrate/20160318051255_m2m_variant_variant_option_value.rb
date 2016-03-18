class M2mVariantVariantOptionValue < ActiveRecord::Migration
  def change
   create_table :variant_option_values_variants, id: false do |t|
      t.belongs_to :variant, index: true
      t.belongs_to :variant_option_value, index: true
    end
  end
end
