Class User < ActiveRecord::Base
  has_many :applications
  has_many :languages
end 