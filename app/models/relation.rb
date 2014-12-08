class Relation < ActiveRecord::Base

  validates :follower_id, presence: true
  validates :following_id, presence: true

  # entry (follower_id + following_id) is uniq
  validates_uniqueness_of :follower_id, scope: [:following_id]
end
