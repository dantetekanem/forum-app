class BoardsController < ApplicationController
  PER_PAGE = 20
  before_action :require_admin, except: [:index, :show]
  before_action :find_board, except: [:index, :new, :create]

  def index
    @boards = Board.by_name
  end

  def show
    @topics = @board.topics.eager_load(:user).not_closed.recent.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def new
    @board = Board.new
    authorize Board
  end

  def create
    @board = Board.new(board_params)
    authorize @board

    if @board.save
      redirect_to board_path(@board), notice: "Board #{@board.name} created successfully."
    else
      flash[:warning] = @board.errors.messages
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: "Board updated successfully."
    else
      flash[:error] = "An error ocurred while updating the board."
      render :edit
    end
  end

  def destroy
    @board.destroy

    redirect_to boards_path, notice: "Board destroyed successfully."
  end

  private

  def find_board
    @board = Board.friendly.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :description, :private)
  end
end
