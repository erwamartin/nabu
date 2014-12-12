class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :resource_name, :devise_mapping
  before_filter :set_data
  layout :get_layout

  def get_layout
    if current_user.nil?
      "landing"
    else 
      "application"
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # Tools methods

  def get_followings_array_id
    following_record = Relation.where(follower_id: current_user.id)
    followings = []

    following_record.each do |following|
      followings = followings + [following.following_id]
    end

    @followings = followings

  end

  def get_followers_array_id
    follower_record = Relation.where(following_id: current_user.id)
    followers = []

    follower_record.each do |follower|
      followers = followers + [follower.follower_id]
    end

    @followers = followers

  end

  private
    def set_data
      if ! current_user.nil?
        @current_user = current_user
        @target_user = current_user
        @followings = current_user.following
        @followers = current_user.followers
        @follows_current_user = current_user.following
        @nb_bookmarks = current_user.bookmarks_posts.count

        user_posts = @target_user.posts.reverse_order
        reposts = @target_user.reposts
        feed_posts = user_posts + reposts
        @posts = feed_posts.sort_by(&:created_at).reverse!
        @nb_posts = @posts.count
      end
    end

  
end
