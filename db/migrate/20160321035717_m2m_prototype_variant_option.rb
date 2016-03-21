class M2mPrototypeVariantOption < ActiveRecord::Migration
  def change
   create_table :prototypes_variant_options, id: false do |t|
      t.belongs_to :prototype, index: true
      t.belongs_to :variant_option, index: true
    end
  end
end
