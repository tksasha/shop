class ProductSearcher < ApplicationSearcher
  searches_with_model :name

  searches_with_model :description
end
