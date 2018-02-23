class ProductsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  def create
    render :errors, status: 422 unless resource.save
  end

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

  def build_resource
    @resource = Product.new resource_params
  end

  def resource_params
    params.require(:product).
      permit(:name, :image, :price, :description, :amount, :discount_price, :currency, category_ids: [])
  end
end
