module CurrentCart
  extend ActiveSupport::Concern

  private

  def set_cart
    if Cart.where(id: session[:cart_id]).present?
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
