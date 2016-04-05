class CreateTaxonomies < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.string :name
      t.string :latin_name

      t.timestamps null: false
    end
  end
end
