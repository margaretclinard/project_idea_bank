require_relative '../test_helper'

# In order to remove project ideas that I am no longer interested in pursuing, I want to delete existing projects.

# Usage Example:

# > ./idea_bank manage
# 1. Add project
# 2. Update project
# 3. Delete project
# 4. View all projects
# > 3
# What project would you like to delete?
# 1. [project name]
# 2. [project name 2]
# 3. [project name 3]
# > 1
# Are you sure you want to delete [project name]? (y/n)
# > y
# [project name] has been deleted.

# Acceptance Criteria:
# * User selects `3` from the main menu.
# * User is prompted to pick from the list of projects in the database.
# * The selected project is deleted and a print out message confirms the deletion.

class DeletingAProject < Minitest::Test

  def test_deleting_projects
    skip
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank manage", "r+") do |pipe|
      expected_output = main_menu
      pipe.puts "2" # Add a project
      expected_output << "Enter project name.\n"
      pipe.puts "Project 1"
      expected_output << <<EOS
Project 1 has been added.
Enter a brief description of the project.
EOS
      pipe.puts "This is an example description."
      expected_output << <<EOS
Project 1
Details: This is an example description.
EOS
      expected_output = main_menu
      pipe.puts "1"
      expected_output << <<EOS
Projects:
1. Project 1
2. Exit
EOS
      pipe.puts "1"
      expected_output << <<EOS
Project Actions:
1. View project details
2. Edit project name
3. Edit project details
4. Delete project
5. Exit
EOS
      pipe.puts "4"
      expected_output << <<EOS
Project has been deleted.
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end