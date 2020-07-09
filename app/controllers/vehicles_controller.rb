class VehiclesController < ApplicationController

  def new
    @user = current_user
  end

  def create
    vehicle = Vehicle.new
    vehicle.save

    Vehicle.add(current_user)
    debugger
  end

  private

  def vehicle_params
  params.require(:vehicles).permit()
  end
end
