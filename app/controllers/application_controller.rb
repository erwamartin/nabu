class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :resource_name, :devise_mapping

  before_filter :set_data
  layout :is_connected

  def set_data
    @current_user = current_user
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

  private
    def is_connected
      if current_user.nil?
        "landing"
      else
        "application"
      end
    end

end
