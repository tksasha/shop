class ProductsController < ApplicationController
  private
  def collection
    @collection ||= Product.includes(:categories).order(:name).page params[:page]
  end

  def destroy_callback
    redirect_to :products
  end
end
