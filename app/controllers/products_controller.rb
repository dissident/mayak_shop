class ProductsController < FrontendController

  def index
    @seo_carrier ||= OpenStruct.new(title: I18n.t('defaults.page_titles.products'))
    @products = Product.all
  end

end
