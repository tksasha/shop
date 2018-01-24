module Twitter
  class SessionsController < ApplicationController
    skip_before_action :authenticate!, only: :create

    def create
      render :errors, status: 422 unless resource.save
    end

    private
    attr_reader :resource

    def resource_params
      params.require(:session).permit(:oauth_token, :oauth_token_secret)
    end

    def build_resource
      @resource = Session.new resource_params
    end

    def policy *args
      SessionPolicy.new current_user, nil
    end
  end
end
