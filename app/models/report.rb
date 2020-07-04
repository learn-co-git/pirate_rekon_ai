class Report < ApplicationRecord
  belongs_to :user
  has_many :images through :user
  has_many :vehicles through :user
end
