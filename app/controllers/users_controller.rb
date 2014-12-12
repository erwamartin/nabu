class UsersController < ApplicationController
  include Devise::Controllers::Helpers

  before_filter :set_data_user, only: [:bookmarks, :display_user]


# Sync method

  def bookmarks
    @posts = @target_user.bookmarks_posts
  end

  def display_user
  	@followings = @target_user.following
    @followers = @target_user.followers
  end

  def get_followings(target_user = current_user)
    @users = target_user.following
    (!@users.empty?) ? (render partial: "partial/follow") : (render text: "no followings")
    
  end

  def get_followers(target_user = current_user)
    @users = target_user.follower
    (!@users.empty?) ? (render partial: "partial/follow") : (render text: "no followers")
    
  end

#end

# AJAX method
  def follow
    relation = current_user.follow(params[:id])
    #relation = Relation.new(follower_id: current_user.id, following_id: params[:id])
    (relation.save) ? (render text: "1") : (render text: "no")
  end

  def unfollow
    relation = current_user.unfollow(params[:id])
    (relation.destroy) ? (render text: "0") : (render text: "no")
  end

#end

  private
    def set_data_user
      @target_user = User.find_by_username(params[:username])
      @nb_bookmarks = @target_user.bookmarks_posts.count

      user_posts = @target_user.posts.reverse_order
      reposts = @target_user.reposts
      feed_posts = user_posts + reposts
      @posts = feed_posts.sort_by(&:created_at).reverse!
      @nb_posts = @posts.count
    end

end
