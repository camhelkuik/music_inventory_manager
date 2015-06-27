require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class MediaType
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :type
  attr_reader :id
  
  def initialize(options = {})
    @id = options["id"] 
    @type = options["type"] 
  end
  
  # Finds an existing entry in the table and creates an object for it.
  #
  # id - Integer, media type id
  #
  # Returns a new object. 
  def self.find_as_objects(id)    
     result = self.find(id).first
    
     MediaType.new(result)
  end
  
  # Changes an object to a String.
  #
  # Returns a String. 
  def to_s
    s = id, type
  end
  
  # Deletes a row from the table.
  #
  # Returns a Boolean.
  def delete_media    
     if MusicCollection.where_find_rows("media_type_id", @id) == []
       self.delete
     else
       false
     end
   end
end