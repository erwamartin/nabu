class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :resource_name, :devise_mapping

  before_action :before_action
  layout "application"

  def before_action
    if current_user.nil?
      @user = User.new
      render :template => "landing/index", :layout => false
    else 
      @current_user = current_user
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

  # Tools methods :) [place à redéfinir]

  def get_followings_array_id(user = current_user)
    following_record = Relation.where(follower_id: user.id)
    followings = []

    following_record.each do |following|
      followings = followings + [following.following_id]
    end

    @followings = followings

  end

  def get_followers_array_id(user = current_user)
    follower_record = Relation.where(following_id: user.id)
    followers = []

    follower_record.each do |follower|
      followers = followers + [follower.follower_id]
    end

    @followers = followers

  end

# End tools

end
