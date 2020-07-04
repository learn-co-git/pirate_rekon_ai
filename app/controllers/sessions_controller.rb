class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :github, :welcome]

  def new
    @user = User.new
  end

  def github
     @user = User.find_or_create_by_omniauth(email: auth['info']['email']) do |u|
         u.password = auth['uid']
     end
     session[:user_id] = @user.id

     redirect_to user_path(@user)
 end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error] = "Invalid credentials. Please check your name and password."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = "logged out"
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
