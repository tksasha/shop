class ProductsController < ApplicationController
  private
  #
  # GET /products?page=...[&description=...][&name=...]
  #
  def collection
    unless @collection
      @collection = params[:description] ? Product.find_by_description(params[:description]) : Product

      @collection = @collection.find_by_name(params[:name]) if params[:name]

      @collection = @collection.includes(:categories).order(:name).page params[:page]
    end

    @collection
  end

  def resource_params
    params.require(:product).permit(:name, :image, :price, category_ids: [])
  end

  def destroy_callback
    redirect_to :products
  end
end
