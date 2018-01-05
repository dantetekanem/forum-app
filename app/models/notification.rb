class Notification < ApplicationRecord
  belongs_to :user
  validates :user_id, :visit_path, :message, presence: true

  scope :unreaded, -> { where(readed_at: nil) }
  scope :recent, -> { order(created_at: :desc) }
  after_commit :broadcast_notification, on: :create

  def read!
    touch(:readed_at)
  end

  def readed?
    readed_at.present?
  end

  private

  def broadcast_notification
    ActionCable.server.broadcast "notifications:#{user.id}", {message: message, path: Rails.application.routes.url_helpers.notification_path(id)}
  end
end
