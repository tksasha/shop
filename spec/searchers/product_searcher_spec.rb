require 'rails_helper'

describe ProductSearcher do
  it_behaves_like :search_with_model, attribute: :description, model: Product

  it_behaves_like :search_with_model, attribute: :name, model: Product
end
