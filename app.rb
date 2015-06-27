require"pry"
require "sinatra"
require "sinatra/reloader"
require 'active_support/core_ext/object/blank'

#SQL/database
require "sqlite3"
require_relative"database_setup.rb"

#Models
require_relative "models/music.rb"
require_relative "models/media-type.rb"
require_relative "models/location.rb"

#Controllers
require_relative "controllers/main.rb"
require_relative "controllers/musics.rb"
require_relative "controllers/locations.rb"
require_relative "controllers/media_types.rb"
