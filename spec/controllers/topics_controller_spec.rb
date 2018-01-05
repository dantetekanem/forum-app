require "rails_helper"

RSpec.describe TopicsController, type: :controller do
  let(:user) { users(:jamie) }
  let(:board) { boards(:board_one) }
  let(:topic) { topics(:topic_one) }

  before { login_user(user) }

  describe '#create' do
    it 'create a new topic with a post' do
      expect do
        post :create, params: {
          board_id: board.slug,
          topic: {
            title: "New topic",
            content: "My topic content"
          }
        }
      end.to change { Topic.count }.by(1)
        .and change { Post.count }.by(1)

      is_expected.to redirect_to "/boards/board-one/topics/new-topic"
    end
  end
end
