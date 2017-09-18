require 'rails_helper'

RSpec.describe WidgetsController, type: :controller do
  its(:collection) { should eq Widget }

  describe '#index' do
    before { expect(subject).to receive(:authenticate!) }

    before { expect(subject).to receive(:authorize).with(Widget).and_return(true) }

    before { get :index }

    it { should render_template :index }

    it { should render_with_layout :widgets }
  end
end
