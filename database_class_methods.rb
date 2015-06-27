require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  def results_as_objects(results)
    results_as_objects = []
        
    results.each do |result_hash|
     results_as_objects << self.new(result_hash)
    end
    
    return results_as_objects
  end
  
  def table_name
    table_name = self.to_s.pluralize.underscore
  end
  
  # Get all of the rows for a table.
  #
  # Returns an Array containing Objects for each row.
  def all     
    results = CONNECTION.execute("SELECT * FROM #{self.table_name}")
     
    return self.results_as_objects(results)
  end
  
  # Add a new record to the database.
  #
  # Returns an Object.
  def add(options={})
    column_names = options.keys
    values = options.values
    
    CONNECTION.execute("INSERT INTO #{self.table_name} (#{column_names.join(", ")}) VALUES (#{values.to_s[1...-1]});")
  
    id = CONNECTION.last_insert_row_id
    options["id"] = id
  
    self.new(options)
  end
  
   # Get a single row.
   #
   # record_id - The record's Integer ID.
   #
   # Returns an Array containing the Hash of the row.
   def find(record_id)    
     result = CONNECTION.execute("SELECT * FROM #{self.table_name} WHERE id = #{record_id}").first
     
     self.new(result)
  end
  
  # Get multiple rows based on Integer ID.
  #
  # field_name - the String name of the column to look for the record's ID
  # record_id - The record's Integer ID.
  #
  # Returns an Array containing the Hash of the rows.
  def find_rows(field_name, record_id)    
    results = CONNECTION.execute("SELECT * FROM #{self.table_name} WHERE #{field_name} = #{record_id}")
   
    return self.results_as_objects(results) 
  end
  
  # Get multiple rows based on user inputed String.
  #
  # field_name - the String name of the column to look for the record's ID
  # input - The user inputed String
  #
  # Returns an Array containing the Hash of the rows.
  def search_rows(field_name, input)    
    results = CONNECTION.execute("SELECT * FROM #{self.table_name} WHERE #{field_name} = '#{input}'")
    
    return self.results_as_objects(results)
  end

end