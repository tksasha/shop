RSpec.shared_examples :search_by_attributes do |params|
  let :model { params[:model] || described_class.name.gsub(/Searcher\z/, '').constantize }

  params[:attributes] = [params[:attributes]] unless params[:attributes].respond_to? :each

  params[:attributes].each do |attribute|
    describe "#search_by_#{ attribute }"do
      subject { described_class.new attribute => :value }

      before { expect(model).to receive(:"search_by_#{ attribute }").with(:value).and_return(:collection) }

      its :search { should eq :collection }
    end
  end
end
