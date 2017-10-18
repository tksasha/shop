class ProductSearcher < ApplicationSearcher
  search_by_attributes :name, :description

  private
  def search_by_category_id category_id
    @results = @results.joins(:categories).where(categories: { slug: category_id })
  end
end
