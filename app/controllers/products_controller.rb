class ProductsController < ApplicationController
  private
  def collection
    @collection ||= ProductSearcher.
      search(params).
      includes(:categories).
      order(:name).
      page(params[:page])
  end

  def resource_params
    params.require(:product).permit(:name, :image, :price, category_ids: [])
  end

  def destroy_callback
    redirect_to :products
  end
end
