require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'
class Minitest::Test
  def setup
    Database.load_structure
    Database.execute("DELETE FROM projects;")
  end
end

def add_project(name)
  Database.execute("INSERT INTO projects (name) VALUES (?)", name)
end

def main_menu
  "\nProject Ideas:\n1. View all projects\n2. Add project\n3. Exit\n"
end