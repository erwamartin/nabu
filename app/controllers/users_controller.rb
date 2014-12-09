class UsersController < ApplicationController
  include Devise::Controllers::Helpers


# Sync method
  def display_user
  	@target_user = User.find_by_username(params[:username])
  	@followings = @target_user.following
    @followers = @target_user.followers
    @nb_posts = @target_user.posts.count
    @posts = @target_user.posts
  end

  def get_followings(target_user = current_user)
    @users = target_user.following
    (!@users.empty?) ? (render partial: "feed/suggestusers") : (render text: "no followings")
    
  end

  def get_followers(target_user = current_user)
    @users = target_user.follower
    (!@users.empty?) ? (render partial: "feed/suggestusers") : (render text: "no followings")
    
  end

  def get_suggest_users
  	@users = User.where("id != ?", current_user.id).order("RAND()").limit(2)
  	
  	#(!@users.empty?) ? (render partial: "suggestusers") : (render text: "no suggest")
  end
#end

# AJAX method
  def follow
    relation = current_user.active_relationships.create(following_id: params[:id])
    #relation = Relation.new(follower_id: current_user.id, following_id: params[:id])
    (relation.save) ? (render text: "1") : (render text: "no")
  end

  def unfollow
    relation = current_user.active_relationships.find_by(following_id: params[:id]).destroy
    (relation.destroy) ? (render text: "0") : (render text: "no")
  end


#end

end
