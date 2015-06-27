# Method allows the user to add a music entry to the database.
get "/add_entry" do
  erb :"add/add_entry_form"
end

# Method saves the new entry to the database and takes the user to the confirmation page.
get "/save_entry" do  
  @new_entry = MusicCollection.add({"band_name" => params["band_name"], "album_name" => params["album_name"], 
    "media_type_id" => params["media_type_id"].to_i, "location_id" => params["location_id"].to_i})
  erb :"add/save_entry"  
end
#-----------------------------------------------
# Change information methods

# Method shows the list of music entries and allows user to click entry they wish to change.
get "/change" do
  erb :"change/change_list"
end

# Method has four forms that allows the user to change information on the entry.
get "/change_form/:x" do
  @entry = MusicCollection.find(params["x"].to_i)
  erb :"change/change_form"
end

# Method updates the information from the change_form in the database and takes the user to a confirmation page.
get "/update_entry/:x" do
  @entry = MusicCollection.find(params["x"].to_i)
  @entry.band_name = params["band_name"]
  @entry.album_name = params["album_name"]
  @entry.media_type_id = params["media_type_id"]
  @entry.location_id = params["location_id"]
  @entry.save
  erb :"main/update_success"
end
#------------------------------------------------
# Method shows a list of all the music entries.
get "/read_all" do
  erb :"read/read_all"
end
#-----------------------------------------------
# Method shows the music entries that correspond to the search. 
get "/search_band/:x" do
  @search_b = MusicCollection.search_rows("band_name", params["band_name"])
  erb :"search/search_band"
end

# Method shows the music entries that correspond to the search. 
get "/search_album/:x" do
  @search_a = MusicCollection.search_rows("album_name", params["album_name"])
  erb :"search/search_album"  
end
#-------------------------------------------------
# Method shows list of all the music entries. User then clicks the entry they wish to delete.
get "/delete_list_entry/:x" do
  erb :"delete/delete_list_entry"
end

# Method deletes the choosen entry and bring the user to the confirmation page. 
get "/delete_entry/:x" do
  @d = MusicCollection.new("id" => params["x"].to_i)

  @d.delete
  erb :"delete/delete_success"
end