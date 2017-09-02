class ProductsController < ApplicationController
  def index
    respond_to do |format|
      format.html

      format.json

      format.pdf { render pdf: 'index' }
    end
  end

  private
  #
  # GET /products?page=...[&description=...][&name=...]
  #
  def collection
    unless @collection
      @collection = ProductSearcher
        .search(name: params[:name], description: params[:description])
        .includes(:categories)
        .order(:name)

      @collection = @collection.page params[:page] unless request.format.pdf?
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
