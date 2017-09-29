module Facebook
  class SessionsController < ApplicationController
    skip_before_action :authenticate!, only: :create

    after_action :login_user, only: :create

    private
    def resource_params
      params.require(:session).permit(:access_token)
    end

    def login_user
      session[:auth_token] = resource.auth_token if resource.persisted?
    end
  end
end
