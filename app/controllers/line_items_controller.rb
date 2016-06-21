class LineItemsController < FrontendController

  include CurrentCart
  before_action :set_cart, only: [:create]

  def create
    variant = Variant.find(params[:variant_id])
    @line_item = @cart.line_items.build(variant: variant)

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
    LineItem.find(params[:id]).destroy
    flash[:success] = "Product successfully deleted"
    redirect_to :back
  end

  private

  def line_item_params
    params.require(:line_item).permit(:variant_id, :cart_belongs_to)
  end

end
