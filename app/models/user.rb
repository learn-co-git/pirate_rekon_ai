class User < ApplicationRecord
  has_secure_password
  has_many :reports
  has_many :images
  has_many :vehicles

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, on: :create
  validates :email, uniqueness: true, allow_blank: false
  #before_action :set_image, only: [:show, :edit, :update, :destroy]

  def self.find_or_create_by_omniauth(auth)
   where(uid: auth.uid).first_or_initialize do |user|
     user.uid ||= auth.uid
     user.name = auth.info.name
     user.email = auth.info.email

     if !user.password_digest
       pass = SecureRandom.hex(30)
       user.password = pass
       user.password_confirmation = pass
     end

     user.save
   end
  end

  def create
  end

end
