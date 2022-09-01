class AdminsController < ApplicationController
  before_action :admin_authorize, only: [:index]
  def index
    @users = User.all
  end

  def new
    @hobbies = Hobby.all
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to '/admin', notice: "Account created successfully"
    else
      render :new
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :address, hobby_id: [])
  end
end
