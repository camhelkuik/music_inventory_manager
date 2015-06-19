require "active_support"
require "active_support/inflector"

module DatabaseClassMethods
  
  # Get all of the rows for a table.
  #
  # Returns an Array containing Objects for each row.
  def all
    table_name = self.to_s.pluralize.underscore
     
    results = CONNECTION.execute("SELECT * FROM #{table_name}")
    results_as_objects = []
        
    results.each do |result_hash|
     results_as_objects << self.new(result_hash)
    end
     
    return results_as_objects
  end
  
  # Add a new record to the database.
  #
  # Returns an Object.
  def add(options={})
    column_names = options.keys
    values = options.values
      
    column_names_for_sql = column_names.join(", ")

    individual_values_for_sql = []

    values.each do |value|
      if value.is_a?(String)
        individual_values_for_sql << "'#{value}'"
      else  
        individual_values_for_sql << value
      end  
    end
     
    values_for_sql = individual_values_for_sql.join(", ")

    table_name = self.to_s.pluralize.underscore
 
    CONNECTION.execute("INSERT INTO #{table_name} (#{column_names_for_sql}) VALUES (#{values_for_sql});")
  
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
     table_name = self.to_s.pluralize.underscore
    
     CONNECTION.execute("SELECT * FROM #{table_name} WHERE id = #{record_id}")
  end
  
  # Get multiple rows based on Integer ID.
  #
  # field_name - the String name of the column to look for the record's ID
  # record_id - The record's Integer ID.
  #
  # Returns an Array containing the Hash of the rows.
  def find_rows(field_name, record_id)
    table_name = self.to_s.pluralize.underscore
    
    CONNECTION.execute("SELECT * FROM #{table_name} WHERE #{field_name} = #{record_id}")
  end
  
  # Get multiple rows based on user inputed String.
  #
  # field_name - the String name of the column to look for the record's ID
  # input - The user inputed String
  #
  # Returns an Array containing the Hash of the rows.
  def search_rows(field_name, input)
    table_name = self.to_s.pluralize.underscore
    
    CONNECTION.execute("SELECT * FROM #{table_name} WHERE #{field_name} = '#{input}'")
  end

end