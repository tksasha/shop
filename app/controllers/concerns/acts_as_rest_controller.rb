module ActsAsRESTController
  extend ActiveSupport::Concern

  included do
    helper_method :collection, :resource

    before_action :build_resource, only: :create

    before_action :initialize_resource, only: :new
  end

  def create
    if resource.save
      create_success_callback
    else
      create_failure_callback
    end
  end

  def update
    if resource.update resource_params
      update_success_callback
    else
      update_failure_callback
    end
  end

  def destroy
    resource.destroy

    destroy_callback
  end

  def create_success_callback
    respond_to do |format|
      format.html { redirect_to resource }

      format.json { render }

      format.js { render }
    end
  end

  def create_failure_callback
    respond_to do |format|
      format.html { render :new }

      format.json { render :errors }

      format.js { render :errors }
    end
  end

  def update_success_callback
    respond_to do |format|
      format.html { redirect_to resource }

      format.json { render }

      format.js { render }
    end
  end

  def update_failure_callback
    respond_to do |format|
      format.html { render :edit }

      format.json { render :errors }

      format.js { render :errors }
    end
  end

  def destroy_callback
    respond_to do |format|
      format.html { render }

      format.json { head :no_content }

      format.js { render }
    end
  end

  private
  #
  # CategoriesController => Category
  #
  def resource_model
    @resource_model ||= self.class.name.gsub(/Controller\z/, '').singularize.constantize
  end

  def collection
    @collection ||= resource_model.all
  end

  def resource
    @resource ||= resource_model.find params[:id]
  end

  def initialize_resource
    @resource = resource_model.new
  end

  def build_resource
    @resource = resource_model.new resource_params
  end
end