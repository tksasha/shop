class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError do
    render 'errors/forbidden', status: :forbidden
  end

  helper_method :collection, :resource, :current_user

  before_action :authenticate_user

  before_action :build_resource, only: :create

  before_action :initialize_resource, only: :new

  before_action -> { authorize resource }, except: :index

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
    @current_user ||= User.joins(:auth_tokens).where(auth_tokens: { value: session[:auth_token] }).first
  end

  def authenticate_user
    redirect_to [:new, :session] unless current_user
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
    respond_to do |format|
      format.html { redirect_to resource }

      format.json { render }
    end
  end

  def create_failure_callback
    respond_to do |format|
      format.html { render :new }

      format.json { render :errors }
    end
  end

  def update_success_callback
    respond_to do |format|
      format.html { redirect_to resource }

      format.json { render }
    end
  end

  def update_failure_callback
    respond_to do |format|
      format.html { render :edit }

      format.json { render :errors }
    end
  end

  def destroy_callback
    respond_to do |format|
      format.html { redirect_to resource_sym }

      format.json { render }
    end
  end
end
