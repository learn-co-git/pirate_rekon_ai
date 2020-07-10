class Vehicle < ApplicationRecord
  belongs_to :user

  require 'net/http'
  require 'uri'
  require 'open-uri'
  require 'json'
  require 'base64'
  require 'httparty'
  require 'net/http/post/multipart'

  def new
  end

  def open(url)
  Net::HTTP.get(URI.parse(url))
  end

  def self.get_data(current_user, array)
    vehicles = Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute
    vehicles

      @data = {}
      data_v = []
      data_ocr = []
      data_carnet = []
      (0...vehicles["resources"].length).each do |i|
       if array.include?(vehicles["resources"][i]["public_id"]) == false     #first block text extraction
        url = vehicles["resources"][i]["url"]
        data_v << vehicles["resources"][i]


        ocr = Cloudinary::Api.update(vehicles["resources"][i]["public_id"], :ocr => "adv_ocr")
        extracted_text =  ocr["info"]["ocr"]["adv_ocr"]["data"][0]["textAnnotations"][0]["description"].split("\n")

        possible_plates = extracted_text.select {|ele| ele.length == 7}
        data_ocr << possible_plates                   #create data hash to hold

        headers = {
          'api-key' => Rails.application.credentials[:carnet][:"api-key"], #begin block API describe vehicle
          'Content-Type' => Rails.application.credentials[:carnet][:"Content-Type"]
          }
        body = open(url) {|f| f.read }
        response = HTTParty.post("https://api.carnet.ai/v2/mmg/detect", headers: headers, body: body)
        response = response.body
        result = JSON.parse(response)
        data_carnet << result["detections"][0]["mmg"]
      end
      @data["vehicles"] = data_v
      @data["ocr"] = data_ocr
      @data["carnet"] = data_carnet
    end
    @data
  end

  def self.add(current_user)

    @user_vehicles = Vehicle.all.select {|vehicle| vehicle.user_id == current_user.id}
    public_id_array = []
      if !@user_vehicles == nil
        @user_vehicles.each do |vehicle|
          public_id_array << vehicle.public_id
        end
      end
      @info = Vehicle.get_data(current_user, public_id_array)
      (0...@info["vehicles"].length).each do |i|
        carnet = @info["carnet"][0][i]
        auto = @info["vehicles"][i]
        ocr = @info["ocr"][i][0]
        new_vehicle = Vehicle.new(make: carnet["make_name"], model: carnet["model_name"], year: carnet["years"], plate: ocr, color: "", background: "", user_id: current_user.id, url: auto["url"], public_id: auto["public_id"], report_id: nil)
        new_vehicle.save
    end
  end
end
