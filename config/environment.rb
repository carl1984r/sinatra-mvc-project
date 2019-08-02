require 'bundler'
require 'pry'
require 'sinatra/flash'


Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/development.sqlite'
)

require_all 'app'
