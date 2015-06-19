require"pry"
require "sinatra"
require "sinatra/reloader"

require "sqlite3"

CONNECTION = SQLite3::Database.new("music-library.db")

CONNECTION.results_as_hash = true

CONNECTION.execute("CREATE TABLE IF NOT EXISTS music_collections (id INTEGER PRIMARY KEY, band_name TEXT NOT NULL, album_name TEXT, media_type_id INTEGER, location_id INTEGER NOT NULL);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS media_types (id INTEGER PRIMARY KEY, type TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT);")

require_relative "music.rb"
require_relative "media-type.rb"
require_relative "location.rb"

get "/home" do
  erb :"homepage"
end

#______________________________________________________________________________________
# Add information methods
get "/add" do
  erb :"add_menu"
end

get "/add_entry" do
  erb :"add_entry_form"
end

get "/save_entry" do  
    if  @new_entry = MusicCollection.add({"band_name" => params["band_name"], "album_name" => params["album_name"], "media_type_id" => params["media_type_id"].to_i, "location_id" => params["location_id"].to_i})
      erb :"save_entry"
    else
      "Failure. Try again."
    end
end

get "/add_media" do
  erb :"add_media_form"
end

get "/save_media" do
  if  @new_entry = MediaType.add({"type" => params["type"]})
    erb :"save_media"
  else
    "Failure. Try again."
  end
end

get "/add_location" do
  erb :"add_location_form"
end

get "/save_location" do
  if  @new_entry = Location.add({"name" => params["name"]})
    erb :"save_location"
  else
    "Failure. Try again."
  end
end
#____________________________________________________________________
# Change information methods
