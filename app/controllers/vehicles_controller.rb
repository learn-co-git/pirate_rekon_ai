class VehiclesController < ApplicationController

  def new
    @user = current_user
  end

  def create
    Vehicle.add(current_user)
  end

  private

  def vehicle_params
  params.require(:vehicles).permit(@before)
  end
end
