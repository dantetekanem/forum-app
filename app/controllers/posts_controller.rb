class PostsController < ApplicationController
  before_action :find_board, :find_topic
  before_action :find_post, except: [:create]
  before_action :authorize_post, except: [:create]

  def create
    post = @topic.posts.build(post_params)
    post.user = current_user

    if post.save
      MentionService.new(post.content).notify_users(current_user, post)

      redirect_to board_topic_path(@topic, board_id: @board.slug, anchor: "post-#{post.id}"), notice: 'Post created successfully.'
    else
      redirect_to board_topic_path(@topic, board_id: @board.slug), notice: 'Error creating post.'
    end
  end

  def fetch
    render json: @post.to_json
  end

  def update
    if @post.update(post_params)
      @post.touch(:edited_at)

      redirect_to board_topic_path(@topic, board_id: @board.slug, anchor: "post-#{@post.id}"), notice: 'Post updated successfully.'
    else
      redirect_to board_topic_path(@topic, board_id: @board.slug), error: 'Error updating post.'
    end
  end

  def destroy
    post_service = PostService.new(@post)
    post_service.destroy

    redirect_to post_service.redirect_path, notice: 'Post deleted successfully.'
  end

  private

  def find_board
    @board = Board.friendly.find(params[:board_id])
  end

  def find_topic
    @topic = @board.topics.friendly.find(params[:topic_id])
  end

  def find_post
    @post = @topic.posts.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  def post_params
    params.require(:post).permit(:content, :reply_id)
  end
end
