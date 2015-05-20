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

  def test_adding_a_project
    shell_output = ""
    expected_output = <<EOS
1. Add project
2. View all projects
3. Exit
EOS
    IO.popen("./idea_bank manage", "r+") do |pipe|
      pipe.puts "1"
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
      expected_output << <<EOS
1. Add project
2. View all projects
3. Exit
EOS
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_sad_path_adding_a_project
    skip
    shell_output = ""
    expected_output = <<EOS
1. Add project
2. View all projects
3. Exit
EOS
    test_project = ""
    IO.popen("./idea_bank manage", "r+") do |pipe|
      pipe.puts "1"
      expected_output << "Enter project name.\n"
      pipe.puts test_project
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
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end