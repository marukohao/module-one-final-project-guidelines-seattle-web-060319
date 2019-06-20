
require 'bundler'
Bundler.require

require "sinatra/activerecord"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'
require_all 'app'
require 'artii'
require 'lolcat'
