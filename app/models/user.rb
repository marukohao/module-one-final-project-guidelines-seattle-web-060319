class User < ActiveRecord::Base
  has_many :applications
  has_many :languages
  
  # @loggedinUser

  # setUser(user):
  #   @loggedinUser = user

  #   getUser()
end
