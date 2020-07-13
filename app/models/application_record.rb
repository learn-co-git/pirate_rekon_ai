class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  def cloud_search
    Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def user_images
      Image.all.select {|picture| current_user.id == picture.user_id}
  end

end
