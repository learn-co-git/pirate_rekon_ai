
require 'net/http'
require 'uri'
require 'open-uri'
require 'json'
require 'base64'
require 'httparty'
require 'curb'
require 'open3'
require 'net/http/post/multipart'

url = URI.parse('https://api.platerecognizer.com/v1/plate-reader/')
path = Base64.encode64(Net::HTTP.get(URI.parse("http://res.cloudinary.com/argustwo/image/upload/v1594240679/3/van.jpg")))
File.open(path) do |jpg|
  req = Net::HTTP::Post::Multipart.new url.path,
    "upload" => UploadIO.new(jpg, "image/jpeg", path)
  req['Authorization'] = 'cb7f56d1ac581f4380fa5b0485248d0795aef83f'
  res = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
    http.request(req)
    debugger
  end
end
