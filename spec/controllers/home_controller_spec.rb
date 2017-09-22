require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  its(:resource) { should be_a Home }

  describe '#show' do
    before { get :show }

    it { should render_template :show }
  end
end
