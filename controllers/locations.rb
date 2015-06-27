# Metho allows the user to add a new locatoin to the database. 
get "/add_location" do
  erb :"add/add_location_form"
end

# Method saves the new entry to the database and takes the user to the confirmation page.
get "/save_location" do
   @new_entry = Location.add({"name" => params["name"]})
   erb :"add/save_entry"
end
#------------------------------
# Method shows a list of all the locations and allows user to click on the location they would like to view.
get "/read_l_list/:x" do
  erb :"read/read_l_list"
end

# Method shows all the music entries for a specific location. 
get "/read_l_entries/:x" do
  @read_l = MusicCollection.find_rows("location_id", params["x"].to_i)
  erb :"read/read_l_entries"
end
#----------------------------------
# Method shows list of the locations. User then clicks the entry they wish to delete. 
get "/delete_list_l/:x" do
  erb :"delete/delete_list_l"
end

# Method verifies that the location entry has nothing assigned to it. If there is nothing assigned to it, the entry is then
# deleted. If there is something assigned to it, the user is sent to the delete_failure page.
get "/delete_l/:x" do
  @d = Location.new("id" => params["x"].to_i)
    
  if @d.delete_location
    erb :"delete/delete_success"
  else
    erb :"delete/delete_failure"
  end
end