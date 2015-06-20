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

get "/change" do
  erb :"change_menu"
end

get "/change_list_b_name" do
  erb :"change_list_b_name"
end

get "/change_b_name_form/:x" do
  erb :"change_b_name_form"
end

get "/update_b_name/:x" do
  entry_b = MusicCollection.find_as_objects(params["x"].to_i)
  entry_b.band_name = params["band_name"]
  entry_b.save
  
  erb :"update_success"
end

get "/change_list_a_name" do
  erb :"change_list_a_name"
end

get "/change_a_name_form/:x" do
  erb :"change_a_name_form"
end

get "/update_a_name/:x" do
  entry_a = MusicCollection.find_as_objects(params["x"].to_i)
  entry_a.album_name = params["album_name"]
  entry_a.save
  
  erb :"update_success"
end

get "/change_list_m_type" do
  erb :"change_list_m_type"
end

get "/change_m_type_form/:x" do
  erb :"change_m_type_form"
end

get "/update_m_type/:x" do
  entry_m = MusicCollection.find_as_objects(params["x"].to_i)
  entry_m.media_type_id = params["media_type_id"]
  entry_m.save
  
  erb :"update_success"
end

get "/change_list_location" do
  erb :"change_list_location"
end

get "/change_location_form/:x" do
  erb :"change_location_form"
end

get "/update_location/:x" do
  entry_l = MusicCollection.find_as_objects(params["x"].to_i)
  entry_l.location_id = params["location_id"]
  entry_l.save
  
  erb :"update_success"
end
#_________________________________________________________________

#Read entry methods

get "/read" do
  erb :"read_menu"
end

get "/read_all" do
  erb :"read_all"
end

get "/read_m_type_list/:x" do
  erb :"read_m_type_list"
end

get "/read_m_entries/:x" do
  @read_m = MusicCollection.where_find_rows("media_type_id", params["x"].to_i)
  erb :"read_m_entries"
end

get "/read_l_list/:x" do
  erb :"read_l_list"
end

get "/read_l_entries/:x" do
  @read_l = MusicCollection.where_find_rows("location_id", params["x"].to_i)
  erb :"read_l_entries"
end
#-------------------------------------------------------------
#Delete methods

get "/delete" do
  erb :"delete_menu"
end

get "/delete_list_entry/:x" do
  erb :"delete_list_entry"
end

get "/delete_entry/:x" do
  @d = MusicCollection.new("id" => params["x"].to_i)

  @d.delete
  erb :"delete_success"
end

get "/delete_list_m/:x" do
  erb :"delete_list_m"
end

get "/delete_m/:x" do
  @d = MediaType.new("id" => params["x"].to_i)
    
  if @d.delete_media
    erb :"delete_success"
  else
    erb :"delete_failure"
  end
end

get "/delete_list_l/:x" do
  erb :"delete_list_l"
end

get "/delete_l/:x" do
  @d = Location.new("id" => params["x"].to_i)
    
  if @d.delete_location
    erb :"delete_success"
  else
    erb :"delete_failure"
  end
end