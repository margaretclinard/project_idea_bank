require_relative '../test_helper'

# To store specific project ideas, users can add projects to their idea bank.

# Usage Example:

# > ./idea_bank add [project name]
# [project name]
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
# * User passes in `add` command followed by a project name.
# * The project name is printed with a prompt to enter the project's description and technology stack.
# * Confirmation is printed showing the new project with details.

class AddingANewProject < Minitest::Test

  def test_minimum_arguments_required
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank") do |pipe|
      expected_output = "[Help] Run as: ./idea_bank add [project name]"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_correct_argument_not_given
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank blah") do |pipe|
      expected_output = "[Help] Run as: ./idea_bank add [project name]"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_add_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank add [project_name]") do |pipe|
      expected_output = "[project_name]"
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end