class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :resource_name, :devise_mapping

  before_action :before_action
  layout "application"

  def before_action
    if current_user.nil?
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

end
