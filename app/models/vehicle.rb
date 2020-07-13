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

  def self.get_data(current_user)
    @user = User.find_by_id(current_user.id)

    vehicles = Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute

    array = @user.vehicles.select {|vehicle| vehicle["url"]}

      @data = {}
      data_v = []
      data_ocr = []
      data_carnet = []
      (0...vehicles["resources"].length).each do |i|
       if array.include?(vehicles["resources"][i]["public_id"]) == false || array.empty?    #first block text extraction
        url = vehicles["resources"][i]["url"]
        data_v << vehicles["resources"][i]

        ocr = Cloudinary::Uploader.upload(url, ocr: 'adv_ocr')
        data_ocr << ocr

        headers = {
          'api-key' => Rails.application.credentials[:carnet][:"api-key"], #begin block API describe vehicle
          'Content-Type' => Rails.application.credentials[:carnet][:"Content-Type"]
          }
          
        body = open(url) {|f| f.read }
        response = HTTParty.post("https://api.carnet.ai/v2/mmg/detect", headers: headers, body: body)
        response = response.body
        result = JSON.parse(response)
        data_carnet << result["detections"][0]["mmg"]

      @data["vehicles"] = data_v
      @data["ocr"] = data_ocr
      @data["carnet"] = data_carnet
      end
    end
    @data
  end

  def self.add(current_user)
      @info = Vehicle.get_data(current_user)
      (0...@info["vehicles"].length).each do |i|
        carnet = @info["carnet"][0][i]
        auto = @info["vehicles"][i]
        ocr = @info["ocr"][0]["info"]["ocr"]["adv_ocr"]["data"][0]["textAnnotations"][0]["description"]

        new_vehicle = Vehicle.new(:make => carnet["make_name"], :model => carnet["model_name"], :year => carnet["years"], :plate => ocr, :color => "", :background => "", :user_id => current_user.id, :url => auto["url"], :public_id => auto["public_id"])
        new_vehicle.save
    end
  end
end
