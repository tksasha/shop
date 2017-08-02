class ProductSearcher < ApplicationSearcher
  search_by_attributes :name, :description
end
