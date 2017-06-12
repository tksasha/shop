class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :collection, :resource, :current_user

  before_action :authenticate_user

  before_action :build_resource, only: :create

  before_action :initialize_resource, only: :new
    
  before_action -> { authorize collection }, only: :index
  
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

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    user_not_authorized unless current_user
  end

  def user_not_authorized
    render 'errors/forbidden', status: :forbidden
    return
  end

  #
  # CategoriesController => 'Categories'
  #
  def resource_name
    @resource_name ||= /\A(.*)Controller\z/.match(self.class.name)[1]
  end

  #
  # CategoriesController => :categories
  #
  def resource_sym
    @resource_sym ||= resource_name.downcase.to_sym
  end

  #
  # CategoriesController => Category
  #
  def resource_model
    @resource_model ||= resource_name.singularize.constantize
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

  def create_success_callback
    redirect_to resource
  end

  def create_failure_callback
    render :new
  end

  def update_success_callback
    redirect_to resource
  end

  def update_failure_callback
    render :edit
  end

  def destroy_callback
    redirect_to resource
  end
end
