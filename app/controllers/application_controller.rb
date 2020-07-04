class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?

  def index
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
     return head(:forbidden) unless session.include? :user_id
  end

end
