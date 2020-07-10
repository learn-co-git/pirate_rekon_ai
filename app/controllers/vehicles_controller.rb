class VehiclesController < ApplicationController

  def new
    @user = current_user
  end

  def create
    data = Vehicle.add(current_user)
    (0...data.length).each do |i|
      carnet = data[i]["carnet"][0][0]
      auto = data[i]["vehicles"]
      Vehicle.new(:make => carnet["make_name"], :model => carnet["model_name"], :year => carnet["years"], :plate => data[i]["ocr"][0], :color => "", :background => "", :user_id => current_user.id,  )
    debugger
  end

  private

  def vehicle_params
  params.require(:vehicles).permit()
  end
end
