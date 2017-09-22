class HomeController < ApplicationController
  skip_before_action :authenticate!, only: :show

  skip_before_action :authorize_resource, only: :show

  private
  def resource
    Home.new
  end
end
