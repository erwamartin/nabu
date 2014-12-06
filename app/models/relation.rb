class Relation < ActiveRecord::Base
	# entry (follower_id + following_id) is uniq
  validates_uniqueness_of :follower_id, scope: [:following_id]

end
