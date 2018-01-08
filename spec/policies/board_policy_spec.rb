require "rails_helper"

RSpec.describe BoardPolicy do
  subject { described_class.new(user, board) }
  let(:board) { boards(:board_one) }

  context '#unlocked' do
    let(:user) { users(:jamie) }

    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:destroy) }
  end

  context '#locked' do
    let(:user) { users(:jon) }

    it { is_expected.to_not permit(:create) }
    it { is_expected.to_not permit(:update) }
    it { is_expected.to_not permit(:destroy) }
  end
end
