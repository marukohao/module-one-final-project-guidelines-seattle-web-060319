require_relative '../config/environment'
require_relative '../lib/api_communicator.rb'
require_relative '../lib/cli_interface.rb'
require 'pry'

#here we will put all of our methods to run


cli = CliInterface.new
cli.user_login

binding.pry


