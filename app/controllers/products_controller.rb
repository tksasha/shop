class ProductsController < ApplicationController
  private
  def collection
    @collection ||= Product.includes(:categories).order(:name).page params[:page]
  end

  def resource_params
    params.require(:product).permit(:name, categories: [])
  end

  def build_resource
    @resource = ProductFactory.build resource_params
  end

  def create_success_callback
    redirect_to :products
  end
end
