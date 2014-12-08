class UsersController < ApplicationController
  include Devise::Controllers::Helpers

  def show

  	@users = User.where("id != ?", current_user.id)
  	# return an array of ids the current_user follows
  	@follows = self.get_followings_array_id

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

  def get_followings
  	followings_array_id = get_followings_array_id
  	@users = User.where(id: followings_array_id)

  	(!@users.empty?) ? (render partial: "follow") : (render text: "no followings")
  	
  end

  def get_followers
  	followers_array_id = get_followers_array_id
  	@users = User.where(id: followers_array_id)

  	(!@users.empty?) ? (render partial: "follow") : (render text: "no followers")
  end

  def get_suggest_users
  	@users = User.where("id != ?", current_user.id).order("RAND()").limit(2)
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end

end
