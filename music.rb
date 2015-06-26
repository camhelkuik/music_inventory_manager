require_relative "database_class_methods.rb"
require_relative "database_instance_methods.rb"

class MusicCollection
  extend DatabaseClassMethods
  include DatabaseInstanceMethods
  
  attr_accessor :band_name, :album_name, :media_type_id, :location_id
  attr_reader :id
  
  def initialize(options = {})
      @id = options["id"]
      @band_name = options["band_name"]
      @album_name = options["album_name"]
      @media_type_id = options["media_type_id"]
      @location_id = options["location_id"]
    end
  
  # Finds an existing entry in the table and creates an object for it.
  #
  # id - Integer, the music id
  #
  # Returns a new Object. 
  def self.find_as_objects(id)    
     result = self.find(id).first
    
     MusicCollection.new(result)
   end
  
  # Allows all the rows of a certain column to be read.
  #
  # input - Integer, the id to be read.
  #
  # Returns an Array of objects of all the entries in a specified column.
  def self.where_find_rows(field_name, input)
    results = self.find_rows(field_name, input)
    results_as_objects = []
  
    results.each do |result_hash|
    results_as_objects << MusicCollection.new(result_hash)
    end
  
    return results_as_objects
  end

  # Uses user input to search a column of the music_collection table.
  #
  # input - String, the one word search parameter.
  #
  # Returns an Array of objects of all the entries that include the search word in the band_name column.
  def self.where_search_rows(field_name, input)
    results = self.search_rows(field_name, input)
    results_as_objects = []
  
    results.each do |result_hash|
     results_as_objects << MusicCollection.new(result_hash)
    end
  
    return results_as_objects
  end
  
  # Changes an object to a String.
  #
  # Returns a String. 
  def to_s
    s = id, band_name, album_name, media_type_id, location_id
  end
  
  # Allows information that was changed in ruby to be saved to SQL.
  #
  # Returns self, an object.
  def save
    CONNECTION.execute("UPDATE music_collections SET band_name = '#{self.band_name}', album_name = '#{self.album_name}',
     media_type_id = #{self.media_type_id}, location_id = #{self.location_id} WHERE id = #{self.id};")
    return self
  end  
end
