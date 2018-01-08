require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:user) { users(:jamie) }
  let(:jon) { users(:jon) }
  let(:board) { boards(:board_one) }
  let(:topic) { topics(:topic_one) }
  let(:post_one) { topic.posts.first }
  let(:post_two) { topic.posts.last }

  before { login_user(user) }

  describe '#create' do
    it 'create new post' do
      expect do
        post :create, params: {
          board_id: board.slug,
          topic_id: topic.slug,
          post: {
            content: 'My new post content.'
          }
        }
      end.to change { Post.count }.by(1)
    end
  end

  describe '#update' do
    it 'update post' do
      put :update, params: {
        board_id: board.slug,
        topic_id: topic.slug,
        id: post_one.id,
        post: {
          content: 'Updated post'
        }
      }

      post_one.reload
      expect(post_one.edited_at).to_not be_nil
      expect(post_one.content).to eq "Updated post"
    end

    it "can't update other user post" do
      login_user(jon)

      expect do
        put :update, params: {
          board_id: board.slug,
          topic_id: topic.slug,
          id: post_one.id,
          post: {
            content: 'Updated post'
          }
        }
      end.to raise_error Pundit::NotAuthorizedError
    end
  end

  describe '#destroy' do
    it 'destroy a normal post' do
      expect do
        delete :destroy, params: {
          board_id: board.slug,
          topic_id: topic.slug,
          id: post_two.id
        }
      end.to change { Post.count }.by(-1)
    end

    it 'destroy the first post (and all posts) and the topic' do
      expect do
        delete :destroy, params: {
          board_id: board.slug,
          topic_id: topic.slug,
          id: post_one.id
        }
      end.to change { Post.count }.by(-2)
        .and change { Topic.count }.by(-1)
    end
  end
end
