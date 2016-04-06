ActiveAdmin.register Taxonomy do

  permit_params :name, :multiple, taxons_attributes:[ :id, :name, :_destroy ]

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
      row :multiple
      panel "Классы" do
        table_for taxonomy.taxons do |taxon|
          column :name
        end
      end

    end

  end

  ## FORM

  form html: { multipart: true } do |f|
    f.inputs '' do
      f.input :name
      f.input :multiple
      f.inputs do
        f.has_many :taxons, { allow_destroy: true } do |taxon|
          taxon.input :name
        end
      end    end

    f.actions
  end
end
