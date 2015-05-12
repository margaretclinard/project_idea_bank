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
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank manage", "r+") do |pipe|
      expected_output = <<EOS
1. Add project
2. Update project
3. Delete project
4. View all projects
EOS
      pipe.puts "3"
      expected_output << "What project would you like to delete?\n"
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end