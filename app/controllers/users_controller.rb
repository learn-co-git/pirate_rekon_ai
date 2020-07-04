class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create] #allows these 2 methods to skip authorized
  def new
    @user = User.new
  end

  def create
    binding.pry
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(current_user)
    else
        render :new
    end
  end

  def show
   @user = User.find_by_email(params[:email])
 end

  private

  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
