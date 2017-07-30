RSpec.shared_examples :search_with_model do |params|
  describe "#search_by_#{ params[:attribute] }"do
    subject { described_class.new params[:attribute] => :value }

    before { expect(params[:model]).to receive(:"search_by_#{ params[:attribute] }").and_return(:collection) }

    its :search { should eq :collection }
  end
end