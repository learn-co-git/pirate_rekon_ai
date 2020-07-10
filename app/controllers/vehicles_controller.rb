class VehiclesController < ApplicationController

  def new
    @user = current_user
  end

  def create
    Vehicle.add(current_user)
    debugger
  end

  private

  def vehicle_params
  params.require(:vehicles).permit()
  end
end
