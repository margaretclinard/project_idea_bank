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

  def test_update_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank manage", "r+") do |pipe|
      expected_output = <<EOS
1. Add project
2. Update project
3. Delete project
4. View all projects
EOS
      pipe.puts "2"
      expected_output << "What project would you like to update?\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end