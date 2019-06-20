class User < ActiveRecord::Base
  has_many :applications

  # @loggedinUser

  # setUser(user):
  #   @loggedinUser = user

  #   getUser()
end
