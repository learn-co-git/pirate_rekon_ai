class VehiclesController < ApplicationController
  layout "user"

  def index
    if params[:report_id]
      @vehicles = Vehicle.find(params[:report_id]).vehicles
    else
      @vehicles = Vehicle.all
    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @user = current_user
  end

  def create
    Vehicle.add(current_user)
    redirect_to '/vehicles'
  end
end
