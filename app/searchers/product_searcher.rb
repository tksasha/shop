class ProductSearcher < ApplicationSearcher
  def search_by_name name
    @results.search_by_name name
  end

  def search_by_description description
    @results.search_by_description description
  end

  def search_by_category_id category_id
    @results.joins(:categories).where(categories: { slug: category_id })
  end
end
