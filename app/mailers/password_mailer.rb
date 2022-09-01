class PasswordMailer < ApplicationMailer

  # Sends a mail to user having a password reset link
  def reset
    token(:user)
  end

  def admin_reset
    token(:admin)
  end

  def token(kind)
    @token = params[kind].signed_id(purpose: "password_reset", expires_in: 5.minutes)
    mail to: params[kind].email
  end
end
