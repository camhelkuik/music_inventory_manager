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
