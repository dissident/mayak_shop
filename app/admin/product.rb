ActiveAdmin.register Product do

  permit_params do
    params = [:name, :description, :slug, :prototype_id, :properties]
    variants_attributes = [ :id, :sku, :width, :_destroy ]
    VariantOption.all.each do |option|
      variants_attributes << option.latin_name.to_sym
    end
    params.push(variants_attributes: variants_attributes)
    params
  end

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
        @product.prototype.variant_options
      end
    end

    def update
      @product = Product.find(params[:id])
      @product.assign_attributes(permitted_params[:product].except(:variants_attributes))
      deleted_variants = []
      will_be_saved_variants = []
      permitted_params[:product][:variants_attributes].each do |variant|
        if variant.second[:id].present?
          varik = Variant.find(variant.second[:id])
          if variant.second[:_destroy] == 1
            deleted_variants << varik
          else
            varik.add_fields(@product.prototype.variant_options)
            varik.assign_attributes(variant.second.except(:id, :_destroy))
            will_be_saved_variants << varik
          end
        else
          varik = Variant.new
          varik.add_fields(@product.prototype.variant_options)
          varik.assign_attributes(variant.second)
          varik.product = @product
          will_be_saved_variants << varik
        end
      end
      if @product.valid? & (will_be_saved_variants.map{ |v| v.valid? }.reduce(:&))
        @product.save
        will_be_saved_variants.map{ |v| v.save }
        redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
      # super do |format|
      #   set_properties(@product, params[:properties])
      # end
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
        variant.input :sku
        variant.input :width
        variant.object.add_fields(f.object.prototype.variant_options)
        f.object.prototype.variant_options.each do |option|
          variant.input option.latin_name.to_sym, as: :select2, collection: options_from_collection_for_select(option.variant_option_values, "id", "value", (option.variant_option_values.ids & variant.object.variant_option_values.ids).first), label: option.name
        end
      end
    end

    f.actions
  end
end
