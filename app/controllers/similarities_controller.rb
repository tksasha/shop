class SimilaritiesController < ApplicationController
  skip_before_action :authenticate!, only: :index

  private
  def collection
    @collection ||= SimilaritySearcher.search params
  end
end
