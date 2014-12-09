class UsersController < ApplicationController
  include Devise::Controllers::Helpers

# test method
  def show

  	@users = User.where("id != ?", current_user.id)
  	# return an array of ids the current_user follows
  	@follows = get_followings_array_id

  	# partials show <=> _show.html.erb
  	(!@users.empty?) ? (render partial: "show") : (render text: "no users")
  end
# end test method

# Sync method
  def display_user
  	@target_user = User.find_by_username(params[:username])
  	@followings = get_followings_array_id(@target_user)
    @followers = get_followers_array_id(@target_user)
  end

  def get_followings(target_user)
  	followings_array_id = get_followings_array_id(target_user)
  	@users = User.where(id: followings_array_id)

  	(!@users.empty?) ? (render partial: "follow") : (render text: "no followings")
  	
  end

  def get_followers(target_user)
  	followers_array_id = get_followers_array_id(target_user)
  	@users = User.where(id: followers_array_id)

  	(!@users.empty?) ? (render partial: "follow") : (render text: "no followers")
  end

  def get_suggest_users
  	@users = User.where("id != ?", current_user.id).order("RAND()").limit(2)
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end
#end

# AJAX method
  def follow
    relation = Relation.new(follower_id: current_user.id, following_id: params[:id])
    relation.save

    (relation.save) ? (render text: "1") : (render text: "no")
  end

  def unfollow
    relation = Relation.where("follower_id = ? AND following_id = ?", current_user.id, params[:id]).take
    relation.destroy

    (relation.destroy) ? (render text: "0") : (render text: "no")
  end


#end

end
