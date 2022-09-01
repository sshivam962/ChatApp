class PasswordResetsController < ApplicationController

  # Create a token and send a link to user's email to reset password
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user.present?
      PasswordMailer.with(user: @user).reset.deliver_now
      redirect_to root_path, notice: "We send a link to your email to reset password"
    else
      redirect_to password_reset_path, alert: "User not found for entered email"
    end
  end

  # Checks that link expired or not if expired redirect to login page.
  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to login_path, alert: "Your token expired, please try again with new link."
  end

  # Sets a new password for user in case of reset
  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')

    if @user.update(password_params(:user))
      redirect_to login_path, notice: "Password changed successfully, Please login."
    else
      render :edit
    end
  end
  def admin_create
    @admin = Admin.find_by(email: params[:admin][:email])
    if @admin.present?
      PasswordMailer.with(admin: @admin).admin_reset.deliver_now
      redirect_to admin_login_path, notice: "We send a link to your email to reset password"
    else
      redirect_to admin_password_reset_path, alert: "User not found for entered email"
    end
  end

  # Checks that link expired or not if expired redirect to login page.
  def admin_edit
    @admin = Admin.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to admin_login_path, alert: "Your token expired, please try again with new link."
  end

  # Sets a new password for user in case of reset
  def admin_update
    @admin = Admin.find_signed!(params[:token], purpose: 'password_reset')

    if @admin.update(password_params(:admin))
      redirect_to admin_login_path, notice: "Password changed successfully, Please login."
    else
      render :admin_edit
    end
  end

  private

  def password_params(kind)
    params.require(kind).permit(:password, :password_confirmation)
  end
end
