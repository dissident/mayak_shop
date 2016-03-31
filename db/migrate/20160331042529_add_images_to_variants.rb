class AddImagesToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :image_fas, :string
    add_column :variants, :image_profile, :string
    add_column :variants, :price, :integer
  end
end
