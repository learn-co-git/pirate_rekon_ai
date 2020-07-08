class Vehicle < ApplicationRecord
  require 'net/http'
  require 'open-uri'
  require 'json'
  require 'base64'
  require 'httparty'

  belongs_to :user

  def open(url)
  Net::HTTP.get(URI.parse(url))
  end

  # def cloud_search_vehicles
  #   Cloudinary::Search
  #   .expression("folder=#{current_user.id}")
  #   .execute
  # end

  def self.add(current_user)
    vehicles = Cloudinary::Search
    .expression("folder=#{current_user.id}")
    .execute
    url = vehicles["resources"][0]["url"]

    headers = {
      'api-key' => Rails.application.credentials[:carnet][:"api-key"],
      'Content-Type' => Rails.application.credentials[:carnet][:"Content-Type"]
    }

    body = open(url) {|f| f.read }
    response = HTTParty.post("https://api.carnet.ai/v2/mmg/detect", headers: headers, body: body)

  # body = open(url) {|f| f.read }
  #   binding.pry
  #   response = HTTParty.post("https://api.carnet.ai/v2/mmg", headers: headers, body: body)
    #result = JSON.parse(response.body)

    # uri = URI.parse("https://api.carnet.ai/v2/mmg")
    # body = open(url) {|f| f.read }
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = true
    # @data = http.get(uri.request_uri)
    debugger

  end
end
