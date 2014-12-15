class UsersController < ApplicationController
  include Devise::Controllers::Helpers

  before_filter :set_data_user, only: [:bookmarks, :display_user, :get_feed_user]


# Sync method

  def bookmarks
    @posts = @target_user.bookmarks_posts.reverse_order.first(3)
  end

  def display_user
  	@followings = @target_user.following
    @followers = @target_user.followers
    
    def display_user
    @followings = @target_user.following
    @followers = @target_user.followers
    
    user_posts = @target_user.posts.reverse_order
    reposts = @target_user.reposts
    feed_posts = user_posts + reposts
    @posts = feed_posts.sort_by(&:created_at).reverse!
   end
  end



  def get_followings(target_user = current_user)
    @users = target_user.following
    (!@users.empty?) ? (render partial: "users/follow") : (render text: "no followings")
    
  end

  def get_followers(target_user = current_user)
    @users = target_user.follower
    (!@users.empty?) ? (render partial: "users/follow") : (render text: "no followers")
    
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

  def get_feed_user
    @posts = @target_user.posts.where("id < ?", params[:id_last_post]).reverse_order.first(5)
    (!@posts.empty?) ? (render partial: "posts/posts_list") : (render text: "0")
  end

  def get_bookmarks_user
    @posts = @target_user.bookmarks_posts.where("post_id < ?", params[:id_last_post]).reverse_order.first(3)
    (!@posts.empty?) ? (render partial: "posts/posts_list") : (render text: "0")
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
