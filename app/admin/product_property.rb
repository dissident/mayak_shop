ActiveAdmin.register ProductProperty do

  permit_params :name, product_property_values_attributes:[ :id, :value, :_destroy, :image, :image_cache]

  menu parent: "Товары"

  ## INDEX

  index download_links: false do
    selectable_column
    column :name
    actions
  end

  ## SHOW

  show do
    attributes_table do
      row :name
    end

    panel "Значения" do
      table_for product_property.product_property_values do
        column :value
      end
    end
  end

  ## FORM

  form html: { multipart: true } do |f|
    f.inputs '' do
      f.input :name
      f.inputs do
        f.has_many :product_property_values, { heading: 'Значения',
                                             allow_destroy: true,
                                             new_record: 'Добавить значение' } do |a|
          a.input :value
          a.input :image
          a.input :image_cache, as: :hidden
        end
      end
    end

    f.actions
  end
end
