class ProductsController < ApplicationController
  def show
    respond_to do |format|
      format.html

      format.pdf { render pdf: 'show' }
    end
  end

  private
  #
  # GET /products?page=...[&description=...][&name=...]
  #
  def collection
    @collection ||= ProductSearcher
      .search(name: params[:name], description: params[:description])
      .includes(:categories)
      .order(:name)
      .page params[:page]
  end

  def resource_params
    params.require(:product).permit(:name, :image, :price, category_ids: [])
  end

  def destroy_callback
    redirect_to :products
  end
end
