ActiveAdmin.register Prototype do

  permit_params :name, product_property_ids:[], variant_option_ids:[]

  menu parent: "Товары"

  ## INDEX

  index download_links: false do
    selectable_column
    id_column
    column :name

    actions
  end

  ## SHOW

  show do
    attributes_table do
      row :name
      row(:product_properties){ prototype.product_properties.map{ |p| p.name }.join(", ") }
      row(:variant_options){ prototype.variant_options.map{ |v| v.name }.join(", ") }
    end

  end

  ## FORM

  form html: { multipart: true } do |f|
    f.inputs '' do
      f.input :name
      f.input :product_properties, as: :select2_multiple
      f.input :variant_options, as: :select2_multiple
    end

    

    f.actions
  end
end
