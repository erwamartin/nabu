class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :resource_name, :devise_mapping
  layout :get_layout

  def get_layout
    if current_user.nil?
      "landing"
    else 
      @current_user = current_user
      @target_user = current_user
      @followings = current_user.following
      @followers = current_user.followers
      @follows_current_user = current_user.following
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

  
end
