require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

namespace :db do

    def reload!
        load_all './app'
    end

    desc 'migrates the database'
    task :migrate do 
        connection_details = YAML::load(File.open('config/database.yml'))
        ActiveRecord::Base.establish_connection(connection_details)     
        ActiveRecord::Migration.migrate('db/migrate/')
    end

    desc 'starts console'
    task :console do
        Pry.start
    end 

end