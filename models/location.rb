require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class Location
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :name
  attr_reader :id
  
  def initialize(options = {})
    @id = options["id"]
    @name = options["name"]
  end
  
  # Changes an object to a String.
  #
  # Returns a String. 
  def to_s
    s = id, name
  end
  
  # Deletes a row from the table.
  #
  # Returns a Boolean.
  def delete_location
    if MusicCollection.find_rows("location_id", @id) == []
      self.delete
    else
      false
    end
  end
  
end