
require 'net/http'
require 'uri'
require 'open-uri'
require 'json'
require 'base64'
require 'httparty'
require 'net/http/post/multipart'
require 'cloudinary'

CLOUDINARY_URL="cloudinary://878221219951367:eldWr7Y5drgSfWrc6kg-zN9R3Fo@argustwo"




    data = []

      url = "https://res.cloudinary.com/argustwo/image/upload/v1594322180/4/IMG_0239.jpg"
      ocr = Cloudinary::Api.update("/4/IMG_0239", :cloud_name => "argustwo", :api_key => "878221219951367", :api_secret => "eldWr7Y5drgSfWrc6kg-zN9R3Fo", :ocr => "adv_ocr")
      data[0] = {}
      data[0]["ocr"] = ocr                                                  #create data hash to hold

      headers = {
        'api-key' => "efdcc0c9-d06d-4907-97fd-0fe206c1d843", #begin block API describe vehicle
        'Content-Type' => 'application/octet-stream'
        }
      body = open(Net::HTTP.get(URI.parse(url))) {|f| f.read }
      response = HTTParty.post("https://api.carnet.ai/v2/mmg/detect", headers: headers, body: body)
      response = response.body
      result = JSON.parse(response.body)

      data[0]["carnet"] = result
      debugger
      data
