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

end