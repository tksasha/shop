class CategorySearcher < ApplicationSearcher
  def search_by_name name
    @results.search_by_name name
  end
end
