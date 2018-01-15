class PurchasesController < ApplicationController
  def create
    render :errors, status: 422 unless resource.save
  end

  def update
    if resource.update resource_params
      head 204
    else
      render :errors, status: 422
    end
  end

  def destroy
    resource.destroy

    head 204
  end

  private
  def resource
    @resource ||= Purchase.find params[:id]
  end

  def resource_params
    params.require(:purchase).permit(:amount, :product_id)
  end

  def build_resource
    @resource = PurchaseFactory.build current_user.id, resource_params
  end
end
