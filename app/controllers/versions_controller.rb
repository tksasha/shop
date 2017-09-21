class VersionsController < ApplicationController
  skip_before_action :authenticate!, only: :show

  private
  def resource
    @resource ||= Version.first
  end
end
