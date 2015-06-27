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
     if MusicCollection.find_rows("media_type_id", @id) == []
       self.delete
     else
       false
     end
   end
end