require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

def add_project(name)
  Database.execute("INSERT INTO projects (name) VALUES (?)", name)
end

def setup_database
  Database.execute <<-SQL
  CREATE TABLE IF NOT EXISTS projects (
    id integer PRIMARY KEY AUTOINCREMENT,
    name varchar(55) NOT NULL
  );
SQL
  Database.execute("DELETE FROM projects;")
end