class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  delegate :board, to: :topic
  validates :content, presence: true

  scope :older, -> { order(created_at: :asc) }

  def edited?
    edited_at.present?
  end

  def first_post?
    self == topic.posts.first
  end
end
