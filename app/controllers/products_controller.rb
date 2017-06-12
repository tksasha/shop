class ProductsController < ApplicationController
  helper_method :eager_loaded_collection
  
  private
  def eager_loaded_collection
    @eager_loaded_collection ||= Product.includes(:categories) 
  end
end
