class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.string :name
      t.belongs_to :taxonomy, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
