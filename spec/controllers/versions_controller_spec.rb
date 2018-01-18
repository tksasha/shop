require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(Version).to receive(:first).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  it_behaves_like :show, anonymous: true
end
