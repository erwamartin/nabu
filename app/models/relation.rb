class Relation < ActiveRecord::Base
	
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :follower_id, presence: true
  validates :following_id, presence: true


  # entry (follower_id + following_id) is uniq
  validates_uniqueness_of :follower_id, scope: [:following_id]
end
