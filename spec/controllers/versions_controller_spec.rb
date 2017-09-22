require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  it_behaves_like :show, format: :json, skip_authenticate: true
end
