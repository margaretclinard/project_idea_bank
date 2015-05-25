require_relative '../test_helper'

# To store specific project ideas, users can add projects to their idea bank.

# Usage Example:
# > ./idea_bank manage
# 1. Add project
# 2. Update project
# 3. Delete project
# 4. View all projects
# > 1
# Enter project name.
# > [project name]
# Enter a brief description of the project.
# > This is an example user input of project description.
# [project name]
# Description: This is an example user input of project description.
# What technologies will be used in the creation of this project?
# 1. HTML
# 2. CSS
# 3. JavaScript
# 4. AngularJS
# 5. Ruby
# > 5
# [project name]
# Details: This is an example user input of project description.
# Stack: Ruby

# Acceptance Criteria:
# * User selects `1` from the main menu.
# * User is prompted to enter the project details.
# * The project name, description, and stack is printed.

class AddingANewProject < Minitest::Test

#   def test_adding_a_project
#     shell_output = ""
#     expected_output = ""
#     IO.popen("./idea_bank manage", "r+") do |pipe|
#       expected_output = main_menu
#       pipe.puts "2" # Add a Project
#       expected_output = "Enter project name."
#       pipe.puts "Project 1"
#       expected_output << <<EOS
# Project 1 has been added.
# Enter a brief description of the project.
# EOS
#       pipe.puts "Description"
#       expected_output << <<EOS
# Project 1
# Details: Description

# Project Ideas:
# 1. View all projects
# 2. Add project
# 3. Exit
# EOS
#       pipe.puts "3" # Exit
#       expected_output = "Goodbye!"
#       pipe.close_write
#       shell_output = pipe.read
#     end
#     assert_equal expected_output, shell_output
#   end

  def test_sad_path_adding_a_project
    skip
    shell_output = ""
    expected_output = main_menu
    IO.popen("./idea_bank manage", "r+") do |pipe|
      pipe.puts "1"
      expected_output << "Enter project name.\n"
      pipe.puts ""
      expected_output << "\"\" is not a valid project name.\n"
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
      pipe.puts "3"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end