class PurchasesController < ApplicationController
  private
  def resource_params
    params.require(:purchase).permit(:amount, :product_id)
  end

  def build_resource
    @resource = PurchaseFactory.build current_user.id, resource_params
  end
end
