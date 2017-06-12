class ProductsController < ApplicationController
  helper_method :collection, :products_for_paginating

  private
  def collection
    @collection ||= Product.includes(:categories)
  end

  def products_for_paginating
    @products_for_paginating ||= Product.order(:name).page params[:page]
  end
end