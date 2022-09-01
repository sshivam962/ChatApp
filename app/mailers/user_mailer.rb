class UserMailer < ApplicationMailer

  #Sends a welcome email after Signup and sends the website url
  def welcome_email
    @user = params[:user]
    @url  = ENV['url']
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
