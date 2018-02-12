class CategoriesController < ApplicationController
  skip_before_action :authenticate!, only: :index

  def create
    render :errors, status: 422 unless resource.save
  end

  private
  attr_reader :resource

  def collection
    @collection ||= CategorySearcher.search Category.order(:slug), params
  end

  def resource_params
    params.require(:category).permit(:name, :image)
  end

  def build_resource
    @resource = Category.new resource_params
  end
end
