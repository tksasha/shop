require 'rails_helper'

describe CategorySearcher do
  it_behaves_like :search_with_model, attribute: :name, model: Category
end
