module VehiclesHelper

  def cloud_search_vehicles
    Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute
  end

  def user_vehicles
    vehicles = cloud_search_vehicles
    vehicles["resources"].length
  end
end
