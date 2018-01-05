class MentionService
  include Rails.application.routes.url_helpers
  delegate :url_helpers, to: 'Rails.application.routes'

  MENTION_REGEX = /[@]+[A-Za-z0-9_]+/
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def notify_users(from_user, post)
    mentions_scan.each do |user|
      Notification.create(
        user: user,
        message: "@#{from_user.username} mentioned you on topic #{post.topic.title}.",
        visit_path: board_topic_path(post.topic, board_id: post.board.slug, anchor: "post-#{post.id}")
      )
    end
  end

  def mentions_scan
    mentions = message.scan(MENTION_REGEX).map { |username| username.delete('@') }
    return [] if mentions.none?

    User.where(username: mentions)
  end

  def mentions_to_links
    message.gsub(MENTION_REGEX) { |user| "<a href='#{user_path(user.delete('@').strip)}'>#{user}</a>" }
  end

  def self.transpile_mentions(message)
    new(message).mentions_to_links
  end
end
