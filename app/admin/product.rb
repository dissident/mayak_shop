ActiveAdmin.register Product do

  permit_params :name, :description, :slug, :prototype_id, variants_ids:[]

  menu parent: "Товары"

  config.clear_action_items!

  action_item only: :index do
    link_to "Создать новый", choose_prototype_admin_products_path
  end

  collection_action :choose_prototype, method: [:get, :post] do
    @product = Product.new
    if request.get?
      render "admin/choose_prototype_form"
    else
      @product.prototype_id = params[:product][:prototype_id]
      redirect_to controller: "products", action: "new", prototype_id: params[:product][:prototype_id]
    end
  end

  before_filter :set_prototype, only: :new

  controller do
    def set_prototype
      @prototype = Prototype.find(params[:prototype_id])
    end
  end

  ## INDEX

  index download_links: false do
    selectable_column
    id_column
    column :name
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
      if f.object.new_record?
        f.input :prototype_id, hint: "<b>#{ prototype.name }</b>".html_safe, input_html: { class: 'hidden', value: prototype.id },
                wrapper_html: { class: 'order_sum_field'}
      else
        f.input :prototype_id, hint: "<b>#{ f.object.prototype.name }</b>".html_safe, input_html: { class: 'hidden', value: f.object.prototype.id },
                wrapper_html: { class: 'order_sum_field'}
      end
      f.input :name
      f.input :description, input_html: { class: 'editor', 'data-type' => f.object.class.name, 'data-id' => f.object.id }
      f.input :slug
      if prototype.product_properties.any?
        render "admin/properties", locals: { prototype: prototype }
      end
    end

    f.inputs do
      f.has_many :variants, { allow_destroy: true } do |variant|
        variant.input :sku
        variant.input :width
        if prototype.variant_options.any?
          render "admin/options", locals: { prototype: prototype }
        end
      end
    end

    f.actions
  end
end
