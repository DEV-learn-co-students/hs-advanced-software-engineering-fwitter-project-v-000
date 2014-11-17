require 'bundler'
Bundler.require

require './app/models/tweet'
require './app/models/user'
require './app/models/follower'
require './app/models/following'

configure :development do
  set :database, "sqlite3:///db/database.db"
end