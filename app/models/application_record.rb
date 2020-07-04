class ApplicationRecord < ActiveRecord::Base
  require 'net/http'
  require 'uri'
  
  self.abstract_class = true
end
