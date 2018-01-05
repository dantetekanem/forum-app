require "rails_helper"

RSpec.describe BoardsController, type: :controller do
  let(:user) { users(:jamie) }
  let(:board) { boards(:board_one) }

  before { login_user(user) }

  describe '#index' do
    before { get :index }
    let(:boards_count) { Board.count }

    it 'list boards' do
      is_expected.to respond_with :ok
      is_expected.to respond_with_content_type :html
      expect(assigns(:boards).size).to eq boards_count
    end
  end

  describe '#show' do
    before { get :show, params: {id: board} }

    it 'show a board' do
      is_expected.to respond_with :ok
      is_expected.to respond_with_content_type :html
      expect(assigns(:board)).to eq board
    end
  end

  describe '#create' do
    it 'create a new board' do
      expect do
        post :create, params: {
          board: {
            name: 'new board',
            description: 'board full description'
          }
        }
      end.to change { Board.count }.by(1)

      expect(Board.last.name).to eq "new board"
      is_expected.to redirect_to "/boards/new-board"
    end

    it 'fails to create a board' do
      expect do
        post :create, params: {
          board: {
            name: '',
            description: 'wow board'
          }
        }
      end.to change { Board.count }.by(0)

      is_expected.to render_template :new
    end
  end

  describe '#update' do
    it 'update a board' do
      put :update, params: {
        id: board.slug,
        board: {
          name: 'Board new name'
        }
      }

      is_expected.to_not render_template :edit
      expect(board.reload.name).to eq "Board new name"
    end
  end

  describe '#destroy' do
    it 'destroy board' do
      expect do
        delete :destroy, params: { id: board.slug }
      end.to change { Board.count }.by(-1)

      is_expected.to redirect_to boards_path
    end
  end
end
