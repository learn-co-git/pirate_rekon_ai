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

  def self.add(current_user)
    vehicles = Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute

    @user_vehicles = Vehicle.all.select {|vehicle| vehicle.user_id == @user.id}
    public_id_array = []
      if !@user_vehicles == nil
        @user_vehicles.each do |vehicle|
          public_id_array << vehicle.public_id
        end
      end
      resources(vehicles, public_id_array)
    end

    def resources(vehicles, array)
      data = []
      (0...vehicles["resources"].length).each do |i|
       if array.includes(vehicles["resources"][i]["public_id"]) == false
        url = vehicles["resources"][i]["url"]
        ocr = Cloudinary::Api.update(vehicles["resources"][i]["public_id"], :ocr => "adv_ocr")
        data[i] = {}
        data[i]["ocr"] = ocr

        headers = {
          'api-key' => Rails.application.credentials[:carnet][:"api-key"],
          'Content-Type' => Rails.application.credentials[:carnet][:"Content-Type"],

          }
        body = open(url) {|f| f.read }
        response = HTTParty.post("https://api.carnet.ai/v2/color/detect", headers: headers, body: body)
        result = response.body
        # result = JSON.parse(response.body)
        debugger
      end
    end
end
