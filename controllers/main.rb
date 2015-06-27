# Method is the homepage menu.
get "/home" do
  erb :"main/homepage"
end

# Method allows user to choose what they would like to add.
get "/add" do
  erb :"main/add_menu"
end

# Method allows user to choose what they would like to view.
get "/read" do
  erb :"main/read_menu"
end

# Method allows user to search for music entries through the band name or album name.
get "/search/:x" do
  erb :"main/search_menu"
end

# Method allows user to choose what they would like to delete. 
get "/delete" do
  erb :"main/delete_menu"
end