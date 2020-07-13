class ApplicationController < ActionController::Base
  
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  helper_method :cloud_search_vehicles
  helper_method :user_vehicles
  helper_method :cloud_search


    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !current_user.nil?
    end

    def authorized
       return head(:forbidden) unless session.include? :user_id
    end

    def cloud_search
      Cloudinary::Search
      .expression("folder=#{current_user.id}")
      .execute
    end

    def cloud_search_vehicles
      Cloudinary::Search
      .expression("folder=#{current_user.id}")
      .execute
    end

    def user_vehicles
      vehicles = cloud_search_vehicles
      vehicles["resources"].length
    end

    def user_images
        Image.all.select {|picture| current_user.id == picture.user_id}
    end


  def index
  end

end
