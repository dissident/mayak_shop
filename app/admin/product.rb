ActiveAdmin.register Product do

  permit_params :name, :description, :slug, :prototype_id, variants_attributes:[ :id, :sku, :width, :_destroy ]

  menu parent: "Товары"

  # config.clear_action_items!

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

  collection_action :option_fields_for_variant, method: :get do
    if request.xhr?
      @prototype = Prototype.find(params[:prototype_id].to_i)
      @variant_id = params[:variant_id].to_i
      render "admin/options", layout: false
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  controller do
    def new
      super do |format|
        if params[:prototype_id].present?
          @product.prototype_id = params[:prototype_id]
        end
      end
    end

    def create
      super do |format|
        set_properties(@product, params[:properties])
      end
    end

    def update
      super do |format|
        # set_options(@product, params[:product][:options])
      end
    end

    private

    def set_options(product, options)
      result = []
      if options.any?
        options.each do |key, value|
          option = VariantOptionValue.find(value)
          result << option
        end
      end
      product.product_property_values = result
    end

    def set_properties(product, properties)
      result = []
      if properties.any?
        properties.each do |key, value|
          property = ProductPropertyValue.find(value)
          result << property
        end
      end
      product.product_property_values = result
    end

    def get_option_id(option_key)
      option_key.to_s.split("_").last.to_i
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
      f.input :prototype_id, hint: "<b>#{ f.object.prototype.name }</b>".html_safe, input_html: { class: 'hidden', value: f.object.prototype.id },
              wrapper_html: { class: 'order_sum_field'}
      f.input :name
      f.input :description, input_html: { class: 'editor', 'data-type' => f.object.class.name, 'data-id' => f.object.id }
      f.input :slug
      if f.object.prototype.product_properties.any?
        render "admin/properties", locals: { prototype: f.object.prototype, product: product }
      end
    end

    f.inputs do
      f.has_many :variants, { allow_destroy: true } do |variant|
        variant.object.add_fields(f.object.prototype.variant_options)
        variant.input :sku
        variant.input :width
        variant.input :tsvet
        # f.object.prototype.variant_options.each do |option|
        #   variant.input option.latin_name.to_sym
        # end
      end
    end

    f.actions
  end
end
