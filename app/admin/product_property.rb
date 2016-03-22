ActiveAdmin.register ProductProperty do

  permit_params :name, product_property_values_attributes:[ :id, :value, :_destroy]

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
        end
      end
    end

    f.actions
  end
end
