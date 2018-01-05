class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  attr_accessor :content

  belongs_to :board
  belongs_to :user
  has_many :posts, dependent: :destroy

  scope :recent, -> { order(updated_at: :desc) }
  scope :not_closed, -> { where(closed_at: nil) }
  scope :closed, -> { where.not(closed_at: nil) }

  def last_post_user
    posts.order(id: :desc).last.user
  end
end
