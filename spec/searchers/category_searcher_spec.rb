require 'rails_helper'

describe CategorySearcher do
  it_behaves_like :search_by_attributes, attributes: :name, model: Category
end
