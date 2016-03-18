class CreateProductProperties < ActiveRecord::Migration
  def change
    create_table :product_properties do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
