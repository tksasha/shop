class ProductsController < ApplicationController
  private
  def collection
    @collection ||= Product.includes(:categories).order(:name).page params[:page]
  end

  def resource_params
    params.require(:product).permit(:name, :image, category_ids: [])
  end

  def destroy_callback
    redirect_to :products
  end
end
