class ProductsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  def show
    render pdf: 'show'
  end

  private
  def resource
    @resource ||= Product.find params[:id]
  end

  def collection
    @collection ||= ProductSearcher.search Product.order(:name).page(params[:page]), params
  end
end
