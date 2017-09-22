require 'rails_helper'

RSpec.describe VersionDecorator do
  describe '#to_json' do
    let(:params) do
      {
        ios_minimal_recomended: '1.0.1',
        ios_minimal_compatible: '0.9.0',
        ios_blocked: ['1.0.0'],
        android_minimal_recomended: '0.0.0',
        android_minimal_compatible: '0.0.0',
        android_blocked: []
      }
    end

    let(:decorator) { described_class.new stub_model(Version, params) }

    subject { JSON.parse decorator.to_json }

    it { expect { subject }.to_not raise_error }

    it do
      should eq({
        'ios' => {
          'minimal_recomended' => '1.0.1',
          'minimal_compatible' => '0.9.0',
          'blocked' => ['1.0.0'],
        },
        'android' => {
          'minimal_recomended' => '0.0.0',
          'minimal_compatible' => '0.0.0',
          'blocked' => [],
        }
      })
    end
  end
end
