ActiveAdmin.register Product do

  permit_params :name, :description, :slug, variants_ids:[]

  ## INDEX

  index download_links: false do
    selectable_column
    id_column
    column :name
    column :description
    column :slug
    column :variants
    actions
  end

  ## SHOW

  show do
    attributes_table do
      row :name
      row(:description) { raw product.description }
      row :slug
      row :variants
    end
  end

  ## FORM

  form html: { multipart: true } do |f|
    f.inputs '' do
      f.input :name
      f.input :description, input_html: { class: 'editor', 'data-type' => f.object.class.name, 'data-id' => f.object.id }
      f.input :slug
    end

    f.inputs do
      f.has_many :variants, { allow_destroy: true } do |variant|
        variant.input :sku
        variant.input :width
      end
    end

    f.actions
  end
end
