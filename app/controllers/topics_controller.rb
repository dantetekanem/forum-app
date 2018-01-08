class TopicsController < ApplicationController
  PER_PAGE = 10
  before_action :find_board
  before_action :find_topic, except: [:new, :create]
  before_action :authorize_topic, only: [:edit, :update, :close, :destroy]

  def show
    @posts = @topic.posts.older.paginate(page: params[:page] || last_posts_page, per_page: PER_PAGE)
  end

  def new
    @topic = @board.topics.new
  end

  def create
    topic_service = TopicService.new(@board, current_user, topic_params)

    if topic_service.create
      redirect_to board_topic_path(topic_service.topic, board_id: @board.slug), notice: 'Topic created successfully.'
    else
      flash[:warning] = topic_service.errors.messages
      render :new
    end
  end

  private

  def find_board
    @board = Board.friendly.find(params[:board_id])
  end

  def find_topic
    @topic = @board.topics.eager_load(posts: [:user]).friendly.find(params[:id])
  end

  def authorize_topic
    authorize @topic
  end

  def last_posts_page
    total_results = @topic.posts.count
    total_results / PER_PAGE + (total_results % PER_PAGE == 0 ? 0 : 1)
  end

  def topic_params
    params.require(:topic).permit(:title, :content)
  end
end
