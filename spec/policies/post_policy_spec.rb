require "rails_helper"

RSpec.describe PostPolicy do
  subject { described_class.new(user, post) }
  let(:post) { posts(:post_one) }

  context '#unlocked' do
    let(:user) { users(:jamie) }

    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:destroy) }
    it { is_expected.to permit(:fetch) }
  end

  context '#locked' do
    let(:user) { users(:jon) }

    it { is_expected.to_not permit(:update) }
    it { is_expected.to_not permit(:destroy) }
    it { is_expected.to_not permit(:fetch) }
  end
end
