class ProductsController < ApplicationController
  private
  def collection
    @collection ||= Product.includes(:categories).order(:name).page params[:page]
  end

  def destroy_callback
    respond_to do |format|
      format.html { redirect_to :products }

      format.json { head :no_content }

      format.js { render }
    end
  end
end
