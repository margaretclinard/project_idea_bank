require_relative '../test_helper'

# In order to update the projects as specific details change, I want to edit projects.
# Usage Example:

# > > ./idea_bank manage
# 1. Add project
# 2. Update project
# 3. Delete project
# 4. View all projects
# > 2
# What project would you like to update?
# 1. [project name]
# 2. [project name 2]
# 3. [project name 3]
# > 1
# Would you like to update [project name]'s:
# 1. Name
# 2. Description
# 3. Technology Stack
# > 2
# Existing description: This is an example user input of project description.
# Enter the new description.
# > This is an example UPDATED user input of project description.
# [project name]
# Details: This is an example UPDATED user input of project description.
# Stack: Ruby
# Finished updating? (y/n)
# > y

# Acceptance Criteria:
# * User selects `2` from the main menu.
# * User is prompted to pick from the list of projects in the database.
# * User is prompted to pick from the details that can be updated.
# * User enters the corresponding updates.
# * The project update is printed along with a yes/no prompt for whether or not the update is complete.

class UpdatingAProject < Minitest::Test

  def test_user_left_projects_unchanged
    shell_output = ""
    expected_output = main_menu
    test_project = "Project 1"
    Project.new(test_project).save
    IO.popen('./idea_bank manage', 'r+') do |pipe|
      pipe.puts "1" # View all projects
      expected_output << "\nProjects:\n"
      expected_output << "1. #{test_project}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << <<EOS

Project Actions:
1. View project details
2. Edit project name
3. Edit project details
4. Delete project
5. Exit
EOS
      pipe.puts "5" # Exit
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_happy_path_editing_a_project
    shell_output = ""
    expected_output = main_menu
    test_project = "Project 1"
    project = Project.new(test_project)
    project.save
    IO.popen('./idea_bank manage', 'r+') do |pipe|
      pipe.puts "1" # View all projects
      expected_output << "\nProjects:\n"
      expected_output << "1. #{test_project}\n"
      expected_output << "2. Exit\n"
      pipe.puts "1"
      expected_output << <<EOS

Project Actions:
1. View project details
2. Edit project name
3. Edit project details
4. Delete project
5. Exit
EOS
      pipe.puts "2" # Edit
      expected_output << "Enter a new name:\n"
      pipe.puts "Project 2"
      expected_output << "Project has been updated to: \"Project 2\"\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
    new_name = Project.find(project.id).name
    assert_equal "Project 2", new_name
  end

end