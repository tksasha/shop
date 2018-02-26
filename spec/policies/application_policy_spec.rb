require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { described_class }

  permissions :index?, :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it { should_not permit double, double }
  end
end
