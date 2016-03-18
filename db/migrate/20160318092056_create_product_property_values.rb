class CreateProductPropertyValues < ActiveRecord::Migration
  def change
    create_table :product_property_values do |t|
      t.string :value
      t.belongs_to :product_property, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
