class ProductsController < ApplicationController
  include Rest

  include Authorization

  private
  def collection
    @collection ||= Product.includes(:categories).order(:name).page params[:page]
  end
end
