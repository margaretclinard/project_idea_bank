require 'sqlite3'
require 'active_record'

class Database
  def self.execute(*args)
    initialize_database unless defined?(@@db)
    @@db.execute(*args)
  end

  def self.initialize_database
    environment = ENV["TEST"] ? "test" : "production"
    database = "db/idea_bank_#{environment}.sqlite"
    @@db = SQLite3::Database.new(database)
    @@db.results_as_hash = true
  end

  def self.load_structure
    Database.execute <<-SQL
    CREATE TABLE IF NOT EXISTS projects (
      id integer PRIMARY KEY AUTOINCREMENT,
      name varchar(55),
      description varchar(55),
      technology varchar(55),
      start varchar(10)
    );
  SQL
  end
end