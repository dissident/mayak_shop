class ProductsController < FrontendController
  def show
    @product = Product.find(params[:id])
    if params[:oprava].present?
      @variant = Variant.joins(:variant_option_values).where(variant_option_values: {id: params[:oprava]}).first
    else
      @variant = @product.variants.first
    end
  end

  def index
    @products = Product.includes(:variants).all
  end
end
