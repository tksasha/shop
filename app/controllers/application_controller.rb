class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :collection, :resource, :current_user

  before_action :build_resource, only: :create

  before_action :initialize_resource, only: :new

  before_action :authorize_resource

  before_action :authenticate_user

  def create
    if resource.save
      create_redirect
    else
      render :new
    end
  end

  def update
    if resource.update resource_params
      update_redirect
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
    @current_user ||= Profile.find(session[:user_id]) if session[:user_id]
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

  def authorize_resource
    authorize resource
  end

  def create_redirect
    redirect_to resource
  end

  def update_redirect
    redirect_to resource
  end
end
