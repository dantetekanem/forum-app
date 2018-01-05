class TopicService
  attr_reader :board, :user, :params, :topic, :errors
  class TopicError < Exception; end

  def initialize(board, user, params)
    @board = board
    @user = user
    @params = params
  end

  def create
    build_topic

    if topic.save
      create_post
    else
      raise TopicService::TopicError.new(topic.errors.messages)
    end
  end

  private

  def build_topic
    @topic = board.topics.build(params.to_h.without(:content))
    @topic.user = user
  end

  def create_post
    post = topic.posts.build(
      user: user,
      content: params[:content]
    )

    unless post.valid?
      topic.destroy
      raise TopicService::TopicError.new('Post not created.')
    else
      post.save
    end
  end
end
