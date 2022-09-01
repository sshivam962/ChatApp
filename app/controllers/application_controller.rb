class ApplicationController < ActionController::Base
  protect_from_forgery
  # Sets the current logged in user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_user, :current_admin

  # checks weather user logged in or not
  def authorize
    redirect_to '/login' unless current_user
  end

  def admin_authorize
    redirect_to '/admin/login' unless current_admin
  end
end
