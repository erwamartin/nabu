class UsersController < ApplicationController
  include Devise::Controllers::Helpers

  before_filter :set_data_user


# Sync method

  def bookmarks
    @posts = @target_user.bookmarks_posts
  end

  def display_user
  	@followings = @target_user.following
    @followers = @target_user.followers
    @posts = @target_user.posts.reverse_order
  end

  def get_followings(target_user = current_user)
    @users = target_user.following
    (!@users.empty?) ? (render partial: "partial/follow") : (render text: "no followings")
    
  end

  def get_followers(target_user = current_user)
    @users = target_user.follower
    (!@users.empty?) ? (render partial: "partial/follow") : (render text: "no followers")
    
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

  private
    def set_data_user
      @target_user = User.find_by_username(params[:username])
      @nb_posts = @target_user.posts.count
      @nb_bookmarks = @target_user.bookmarks_posts.count
    end

end
