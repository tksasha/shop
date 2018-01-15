module ActsAsAuthorizedController
  extend ActiveSupport::Concern

  included do
    include Pundit

    rescue_from Pundit::NotAuthorizedError do
      head :forbidden
    end

    before_action :build_resource, only: :create

    before_action :authorize_resource, except: :index

    before_action :authorize_collection, only: :index

    helper_method :parent, :collection, :resource
  end

  private
  def authorize_resource
    authorize resource
  end

  def authorize_collection
    authorize collection
  end
end
