require 'rails_helper'

RSpec.describe WidgetsController, type: :controller do
  describe '#index' do
    before { get :index }

    it { should render_template :index }

    it { should render_with_layout :widgets }
  end
end
