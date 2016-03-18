ActiveAdmin.register VariantOption do

  permit_params :name, variant_option_values_attributes:[ :id, :value, :_destroy ]

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
      table_for variant_option.variant_option_values do
        column :value
      end
    end
  end

  ## FORM

  form html: { multipart: true } do |f|
    f.inputs '' do
      f.input :name
      f.inputs do
        f.has_many :variant_option_values, { heading: 'Значения',
                            allow_destroy: true,
                            new_record: 'Добавить значение' } do |a|
          a.input :value
        end
      end

    end

    

    f.actions
  end
end
