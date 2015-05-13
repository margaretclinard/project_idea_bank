require 'rubygems'
require 'bundler/setup'
require 'minitest/reporters'
Dir["./app/**/*.rb"].each { |f| require f }
Dir["./lib/*.rb"].each { |f| require f }
ENV["TEST"] = "true"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require 'minitest/autorun'

def add_project(name)
  Database.execute("INSERT INTO projects (name) VALUES (?)", name)
end

class Minitest::Test
  def setup_database
    Database.load_structure
  end
end