class CartsController < FrontendController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  # rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    if @cart.present?
      if session[:cart_id] != @cart.id
        @entry_status = false
      else
        @entry_status = true
      end
      return @entry_status
    end
  end

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  private

  def set_cart
    @cart = Cart.where(id: session[:cart_id]).take
  end

  def cart_params
    params[:cart]
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to products_path, notice: 'Invalid cart'
  end
end
