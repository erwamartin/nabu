class UsersController < ApplicationController

  def show

  	@users = User.where("id != ?", current_user.id)
  	# return an array of ids the current_user follows
  	@follows = self.get_followings

  	# partials show <=> _show.html.erb
  	(!@users.empty?) ? (render partial: "show") : (render text: "no users")
  end

  def follow
    relation = Relation.new(follower_id: current_user.id, following_id: params[:id])
    relation.save

    (relation.save) ? (render text: "1") : (render text: "0")
  end

  def unfollow
    relation = Relation.where("follower_id = ? AND following_id = ?", current_user.id, params[:id]).take
    relation.destroy

    (relation.destroy) ? (render text: "0") : (render text: "1")
  end

# Tools methods :)
  def get_followings
    following_record = Relation.where(follower_id: current_user.id)
    followings = []

    following_record.each do |following|
    	followings = followings + [following.following_id]
    end

    return followings

  end

  def get_followers
    follower_record = Relation.where(following_id: current_user.id)
    followers = []

    follower_record.each do |follower|
    	followers = followers + [follower.follower_id]
    end

    return followers

  end

# End tools methods

end
