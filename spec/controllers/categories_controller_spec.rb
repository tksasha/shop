require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  it_behaves_like :index, format: :json
end
