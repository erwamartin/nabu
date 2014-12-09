class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :resource_name, :devise_mapping

  before_filter :check_authentification
  layout "application"

  def check_authentification
    if current_user.nil?
      @user = User.new
      render :template => "landing/index", :layout => false
    else 
      @current_user = current_user
      @target_user = current_user
      @followings = current_user.following
      @followers = current_user.followers
      @follows_current_user = current_user.following
      @nb_posts = current_user.posts.count
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
