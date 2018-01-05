class Board < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :moderators, dependent: :destroy
  has_many :users, through: :moderators
  has_many :topics, dependent: :destroy
  has_many :posts, through: :topics

  scope :by_name, -> { order(name: :asc) }

  validates :name, presence: true, length: {minimum: 3, maximum: 100}, uniqueness: true
  validates :description, presence: true, length: {minimum: 10}

  def moderated_by?(user)
    moderators.where(user: user).exists?
  end
end
