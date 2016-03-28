class CreateVariantOptions < ActiveRecord::Migration
  def change
    create_table :variant_options do |t|
      t.string :name
      t.string :latin_name

      t.timestamps null: false
    end
  end
end
