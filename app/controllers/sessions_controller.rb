class SessionsController < ApplicationController
  before_action :check_user_logged_in, only: %i[new create]
  before_action :check_admin_logged_in, only: %i[admin_new admin_create]

  def new
  end

  def admin_new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password]) && user.approved
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/',  notice: "Login Successfull"
    elsif user && user.authenticate(params[:password]) && !user.approved
      redirect_to '/login', alert: 'Once site admin approved you, you can login easily'
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login', alert: 'Please check email and password'
    end
  end

  def admin_create
    admin = Admin.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if admin && admin.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:admin_id] = admin.id
      redirect_to '/admin',  notice: "Login Successfull"
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/admin/login', alert: 'Please check email and password'
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      redirect_to '/login', notice: 'Logged out!!! Please Login.'
    else
      session[:admin_id] = nil
      redirect_to '/admin/login', notice: 'Logged out!!! Please Login.'
    end

  end

  def check_user_logged_in
      redirect_to root_path, alert: "Already signed in as #{User.find_by(id: session[:user_id]).name}" unless session[:user_id] == nil
  end
  def check_admin_logged_in
    redirect_to '/admin', alert: "Already signed in as #{Admin.find_by(id: session[:admin_id]).name}" unless session[:admin_id] == nil
  end
end
