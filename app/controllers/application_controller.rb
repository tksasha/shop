class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :collection, :resource, :current_user

  before_action :build_resource, only: :create

  before_action :initialize_resource, only: :new

  def create
    if resource.save
      redirect_to resource
    else
      render :new
    end
  end

  def update
    if resource.update resource_params
      redirect_to resource
    else
      render :edit
    end
  end

  def destroy
    resource.destroy

    redirect_to :root
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_user
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
end
