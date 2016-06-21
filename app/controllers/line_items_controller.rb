class LineItemsController < FrontendController

  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    variant = Variant.find(params[:variant_id])
    @line_item = @cart.add_product(variant.id)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @line_item.cart, notice: 'Product successfully added' }
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity = @line_item.quantity - 1
      @line_item.save
      redirect_to :back
    else
      @line_item.destroy
      flash[:success] = "Product successfully deleted"
      redirect_to :back
    end
  end

  def plus_quantity
    @line_item = LineItem.find(params[:id])
    @line_item.quantity = @line_item.quantity + 1
    @line_item.save
    redirect_to :back
  end

  def minus_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity == 1
      @line_item.quantity
    else
      @line_item.quantity = @line_item.quantity - 1
    end
    @line_item.save
    redirect_to :back
  end

  private

  def line_item_params
    params.require(:line_item).permit(:variant_id, :cart_belongs_to)
  end

end
