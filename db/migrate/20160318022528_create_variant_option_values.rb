class CreateVariantOptionValues < ActiveRecord::Migration
  def change
    create_table :variant_option_values do |t|
      t.string :value
      t.belongs_to :variant_option, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
