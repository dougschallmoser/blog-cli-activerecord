require 'bundler'
Bundler.require
require 'sinatra/activerecord'

require_all 'app'


connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)
