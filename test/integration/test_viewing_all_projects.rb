require_relative '../test_helper'

# In order to see a list of all the projects in my idea bank, the program should print a list of project names.

# > ./idea_bank manage
# 1. Add project
# 2. Update project
# 3. Delete project
# 4. View all projects
# > 4
# My Projects
# 1. [project name]
# 2. [project name 2]
# 3. [project name 3]
# > 1
# [project name]
# Details: This is an example user input of project description.
# Stack: Ruby
# Back? (y/n)
# > y
# My Projects
# 1. [project name]
# 2. [project name 2]
# 3. [project name 3]


# Acceptance Criteria:
# * User selects `4` from the main menu.
# * A list of projects in the database is generated.
# * User can select a project from the list to view it.
# * User can return back to the main list of projects.

class ViewingAllProjects < Minitest::Test

  def test_viewing_no_projects
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank manage", "r+") do |pipe|
      expected_output = main_menu
      pipe.puts "1"
      expected_output << "No projects found. Add a project.\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_viewing_multiple_projects
    skip
    add_project("Project 1")
    add_project("Project 2")
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank manage", "r+") do |pipe|
      expected_output = main_menu
      pipe.puts "1"
      expected_output << <<EOS
=================
All Projects
=================
1. Project 1
2. Project 2
3. Exit
EOS
      pipe.puts "3"
      expected_output = "Goodbye!"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end