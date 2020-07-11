class ReportsController < ApplicationController

  def images_index
    @report = Report.find(params[:id])
    @images = @report.images
    render tempate: 'images/index'
  end

  def image
    @report = Report.find(params[:id])
    @image = Image.find(params[:image_id])
    render template: 'images/show'
  end

  def vehicles_index
    @report = Report.find(params[:id])
    @vehicles = @report.vehicles
    render tempate: 'vehicles/index'
  end

  def vehicle
    @report = Report.find(params[:id])
    @vehicle = Vehicle.find(params[:vehicle_id])
    render template: 'vehicles/show'
  end





end
