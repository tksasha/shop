class ProductsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index)

  def show
    respond_to do |format|
      format.html

      format.pdf { render pdf: 'show' }
    end
  end

  private
  def collection
    @collection ||= ProductSearcher.
      search(params).
      order(:name).
      page(params[:page])
  end

  def resource_params
    params.require(:product).permit :name, :image, :price, :discount_price, :amount, category_ids: []
  end

  def destroy_callback
    redirect_to :products
  end

  def parent
    return unless params[:category_id].present?

    @parent ||= Category.find_by! slug: params[:category_id]
  end
end
