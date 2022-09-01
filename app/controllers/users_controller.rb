class UsersController < ApplicationController
  before_action :authorize, only: [:index]

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def new
    @user = User.new
  end

  #Creates a new User
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.with(user: @user).welcome_email.deliver_later
      redirect_to '/', notice: 'Successfully Signed up.'
    else
      redirect_to '/signup', alert: "Please enter correct details or details may exist."
    end
  end

  def approve
    @user = User.find_by(id: params[:id])
    @user.update_column(:approved, true)
    redirect_to '/admin', notice: 'User approved successfully.'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
