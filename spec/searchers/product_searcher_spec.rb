require 'rails_helper'

describe ProductSearcher do
  it_behaves_like :search_by_attributes, attributes: [:name, :description], model: Product
end
