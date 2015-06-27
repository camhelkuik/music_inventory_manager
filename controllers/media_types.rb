#------------------------------
# Add Media Type
#-------------------------------
# Method allows the user to add a new media type to the database.
get "/add_media" do
  erb :"add/add_media_form"
end

# Method saves the new entry to the database and takes the user to the confirmation page.
get "/save_media" do
  @new_entry = MediaType.add({"type" => params["type"]})
  erb :"add/save_entry"
end
#----------------------------------
# View Media Types
#----------------------------------
# Method shows a list of all the media types and allows user to click on the media type they would like to view.
get "/read_m_type_list/:x" do
  erb :"read/read_m_type_list"
end

# Method shows all the music entries for a specific media type.
get "/read_m_entries/:x" do
  @read_m = MusicCollection.find_rows("media_type_id", params["x"].to_i)
  erb :"read/read_m_entries"
end
#---------------------------------
# Delete Media Types
#---------------------------------
# Method shows list of the media types. User then clicks the entry they wish to delete.
get "/delete_list_m/:x" do
  erb :"delete/delete_list_m"
end

# Method verifies that the media type entry has nothing assigned to it. If there is nothing assigned to it, the entry is then
# deleted. If there is something assigned to it, the user is sent to the delete_failure page.
get "/delete_m/:x" do
  @d = MediaType.new("id" => params["x"].to_i)
    
  if @d.delete_media
    erb :"delete/delete_success"
  else
    erb :"delete/delete_failure"
  end
end