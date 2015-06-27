#Home Music Inventory Manager
I created an database-driven web application inventory manager for my home music collection. The program creates a SQL database with three tables: music_collection, media_types, and locations. Each table can be accessed through a class: MusicCollection, MediaType and Location. The program allows a user to add, read, change and delete information from the various tables. The music collection table has 5 columns: unique id, band name, album name, media type id, and location id. The media type table has 2 columns: a unique id and type of media. The location table has 2 columns: a unique id and name of the different locations. 

##music.rb
The music.rb file is the file for the music_collection table for the program. 


###save method
The save method is an instance method. This method takes information performed in ruby and updates the corresponding row's information.

```ruby
  def save
    CONNECTION.execute("UPDATE music_collection SET band_name = '#{@band_name}', album_name = '#{@album_name}', media_type_id = #{@media_type_id}, location_id = #{@location_id} WHERE id = #{@id};")
    return self
  end
```

##media-type.rb, location.rb and music.rb
The media-type.rb file is the table for the different media types. The location.rb file is the table for the different locations. Both of these classes use the same 5 methods to add, find, read and delete information from their tables. Music.rb also uses these methods.


###delete method
The delete method for the MediaType class and Location class check to see if the instance that is to be deleted is an empty Array. If it is empty then it will delete that instance. If the Array is not empty it will return false. The delete method for MusicCollection does not check for an empty Array.

```ruby   
 def delete_media    
    if MusicCollection.where_find_rows("media_type_id", @id) == []
      self.delete
    else
      false
    end
  end
```

###to_s method
This method will put to string whatever is inside that method. It is used in all of the classes to make the app.rb cleaner. 

