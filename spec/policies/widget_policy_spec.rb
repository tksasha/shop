require 'rails_helper'

describe WidgetPolicy do
  subject { described_class }

  permissions :index? do
    let :resource { double }

    context do
      let :user { nil }

      it { should_not permit user, resource }
    end

    context do
      let :user { stub_model User }

      it { should_not permit user, resource }
    end

    context do
      let :user { stub_model User, roles: :admin }

      it { should permit user, resource }
    end
  end
end
