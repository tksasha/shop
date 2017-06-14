class ProductsController < ApplicationController
  helper_method :collection

  private
  def collection
    @collection ||= Product.includes(:categories).order(:name).page params[:page]
  end
end