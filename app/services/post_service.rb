class PostService
  include Rails.application.routes.url_helpers
  delegate :url_helpers, to: 'Rails.application.routes'

  attr_reader :post
  delegate :topic, :board, to: :post

  def initialize(post)
    @post = post
  end

  def destroy
    if first_post?
      topic.destroy
    else
      post.destroy
    end
  end

  def redirect_path
    if first_post?
      url_helpers.board_path(board)
    else
      url_helpers.board_topic_path(topic, board_id: board.slug)
    end
  end

  private

  def first_post?
    @first_post ||= post.first_post?
  end
end
