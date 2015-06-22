require"pry"
require "sinatra"
require "sinatra/reloader"
require 'active_support/core_ext/object/blank'

require "sqlite3"

CONNECTION = SQLite3::Database.new("music-library.db")

CONNECTION.results_as_hash = true

CONNECTION.execute("CREATE TABLE IF NOT EXISTS music_collections (id INTEGER PRIMARY KEY, band_name TEXT NOT NULL, album_name TEXT, media_type_id INTEGER, location_id INTEGER NOT NULL);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS media_types (id INTEGER PRIMARY KEY, type TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, name TEXT);")

require_relative "music.rb"
require_relative "media-type.rb"
require_relative "location.rb"

# Method is the homepage menu.
get "/home" do
  erb :"homepage"
end

#-----------------------------------------------------------------------

# Add information methods

# Method allows user to choose what they would like to add.
get "/add" do
  erb :"add_menu"
end

# Method allows the user to add a music entry to the database.
get "/add_entry" do
  erb :"add_entry_form"
end

# Method saves the new entry to the database and takes the user to the confirmation page.
get "/save_entry" do  
  @new_entry = MusicCollection.add({"band_name" => params["band_name"], "album_name" => params["album_name"], "media_type_id" => params["media_type_id"].to_i, "location_id" => params["location_id"].to_i})
  erb :"save_entry"  
end

# Method allows the user to add a new media type to the database.
get "/add_media" do
  erb :"add_media_form"
end

# Method saves the new entry to the database and takes the user to the confirmation page.
get "/save_media" do
  @new_entry = MediaType.add({"type" => params["type"]})
  erb :"save_entry"
end

# Metho allows the user to add a new locatoin to the database. 
get "/add_location" do
  erb :"add_location_form"
end

# Method saves the new entry to the database and takes the user to the confirmation page.
get "/save_location" do
   @new_entry = Location.add({"name" => params["name"]})
   erb :"save_entry"
end
#-----------------------------------------------------------------------

# Change information methods

# Method shows the list of music entries and allows user to click entry they wish to change.
get "/change" do
  erb :"change_list"
end

# Method has four forms that allows the user to change information on the entry.
get "/change_form/:x" do
  erb :"change_form"
end

# Method updates the information from the change_form in the database and takes the user to a confirmation page.
get "/update_entry/:x" do
  entry = MusicCollection.find_as_objects(params["x"].to_i)
  unless params["band_name"].blank?
    entry.band_name = params["band_name"]
    entry.save
  end
  unless params["album_name"].blank?
    entry.album_name = params["album_name"]
    entry.save
  end
  unless params["media_type_id"].blank?
    entry.media_type_id = params["media_type_id"]
    entry.save
  end
  unless params["location_id"].blank?
    entry.location_id = params["location_id"]
    entry.save
  end
  erb :"update_success"
end

#--------------------------------------------------------------

# Read entry methods

# Method allows user to choose what they would like to view.
get "/read" do
  erb :"read_menu"
end

# Method shows a list of all the music entries.
get "/read_all" do
  erb :"read_all"
end

# Method shows a list of all the media types and allows user to click on the media type they would like to view.
get "/read_m_type_list/:x" do
  erb :"read_m_type_list"
end

# Method shows all the music entries for a specific media type.
get "/read_m_entries/:x" do
  @read_m = MusicCollection.where_find_rows("media_type_id", params["x"].to_i)
  erb :"read_m_entries"
end

# Method shows a list of all the locations and allows user to click on the location they would like to view.
get "/read_l_list/:x" do
  erb :"read_l_list"
end

# Method shows all the music entries for a specific location. 
get "/read_l_entries/:x" do
  @read_l = MusicCollection.where_find_rows("location_id", params["x"].to_i)
  erb :"read_l_entries"
end
#-------------------------------------------------------------
# Search methods

# Method allows user to search for music entries through the band name or album name.
get "/search/:x" do
  erb :"search_menu"
end

# Method shows the music entries that correspond to the search. 
get "/search_band/:x" do
  @search_b = MusicCollection.where_search_rows("band_name", params["band_name"])
  erb :"search_band"
end

# Method shows the music entries that correspond to the search. 
get "/search_album/:x" do
  @search_a = MusicCollection.where_search_rows("album_name", params["album_name"])
  erb :"search_album"  
end

#-------------------------------------------------------------
# Delete methods

# Method allows user to choose what they would like to delete. 
get "/delete" do
  erb :"delete_menu"
end

# Method shows list of all the music entries. User then clicks the entry they wish to delete.
get "/delete_list_entry/:x" do
  erb :"delete_list_entry"
end

# Method deletes the choosen entry and bring the user to the confirmation page. 
get "/delete_entry/:x" do
  @d = MusicCollection.new("id" => params["x"].to_i)

  @d.delete
  erb :"delete_success"
end

# Method shows list of the media types. User then clicks the entry they wish to delete.
get "/delete_list_m/:x" do
  erb :"delete_list_m"
end

# Method verifies that the media type entry has nothing assigned to it. If there is nothing assigned to it, the entry is then
# deleted. If there is something assigned to it, the user is sent to the delete_failure page.
get "/delete_m/:x" do
  @d = MediaType.new("id" => params["x"].to_i)
    
  if @d.delete_media
    erb :"delete_success"
  else
    erb :"delete_failure"
  end
end

# Method shows list of the locations. User then clicks the entry they wish to delete. 
get "/delete_list_l/:x" do
  erb :"delete_list_l"
end

# Method verifies that the location entry has nothing assigned to it. If there is nothing assigned to it, the entry is then
# deleted. If there is something assigned to it, the user is sent to the delete_failure page.
get "/delete_l/:x" do
  @d = Location.new("id" => params["x"].to_i)
    
  if @d.delete_location
    erb :"delete_success"
  else
    erb :"delete_failure"
  end
end