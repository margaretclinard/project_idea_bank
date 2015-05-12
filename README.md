# project_idea_bank
NSS - Ruby Capstone Project - May 2015

## Project Vision

A command-line program that keeps track of project ideas and details.

Users will be able to add/edit/delete projects and their associated details.

## Features

### Managing your projects

In order to interact with the program, users can view all of the program options from a main menu.

Usage Example:
> ./idea_bank manage
1. Add project
2. Update project
3. Delete project
4. View all projects

Acceptance Criteria:
* User passes in `manage` command
* User can select from a menu of options: Add project, Update project, Delete project, View all projects

### Adding a new project

To store specific project ideas, users can add projects to their idea bank.

Usage Example:

```
> ./idea_bank manage
1. Add project
2. Update project
3. Delete project
4. View all projects
> 1
Enter project name.
> [project name]
Enter a brief description of the project.
> This is an example user input of project description.
[project name]
Description: This is an example user input of project description.
What technologies will be used in the creation of this project?
1. HTML
2. CSS
3. JavaScript
4. AngularJS
5. Ruby
> 5
[project name]
Details: This is an example user input of project description.
Stack: Ruby
```

Acceptance Criteria:
* User selects `1` from the main menu.
* User is prompted to enter the project details.
* The project name, description, and stack is printed.

### Updating a project

In order to update the projects as specific details change, I want to edit projects.

Usage Example:

```
> > ./idea_bank manage
1. Add project
2. Update project
3. Delete project
4. View all projects
> 2
What project would you like to update?
1. [project name]
2. [project name 2]
3. [project name 3]
> 1
Would you like to update [project name]'s:
1. Name
2. Description
3. Technology Stack
> 2
Existing description: This is an example user input of project description.
Enter the new description.
> This is an example UPDATED user input of project description.
[project name]
Details: This is an example UPDATED user input of project description.
Stack: Ruby
Finished updating? (y/n)
> y
```

Acceptance Criteria:
* User selects `2` from the main menu.
* User is prompted to pick from the list of projects in the database.
* User is prompted to pick from the details that can be updated.
* User enters the corresponding updates.
* The project update is printed along with a yes/no prompt for whether or not the update is complete.


### Deleting a project

In order to remove project ideas that I am no longer interested in pursuing, I want to delete existing projects.

Usage Example:

```
> ./idea_bank manage
1. Add project
2. Update project
3. Delete project
4. View all projects
> 3
What project would you like to delete?
1. [project name]
2. [project name 2]
3. [project name 3]
> 1
Are you sure you want to delete [project name]? (y/n)
> y
[project name] has been deleted.
```

Acceptance Criteria:
* User selects `3` from the main menu.
* User is prompted to pick from the list of projects in the database.
* The selected project is deleted and a print out message confirms the deletion.

### Printing a list of all projects

In order to see a list of all the projects in my idea bank, the program should print a list of project names.

```
> ./idea_bank manage
1. Add project
2. Update project
3. Delete project
4. View all projects
> 4
My Projects
1. [project name]
2. [project name 2]
3. [project name 3]
> 1
[project name]
Details: This is an example user input of project description.
Stack: Ruby
Back? (y/n)
> y
My Projects
1. [project name]
2. [project name 2]
3. [project name 3]
```

Acceptance Criteria:
* User selects `4` from the main menu.
* A list of projects in the database is generated.
* User can select a project from the list to view it.
* User can return back to the main list of projects.
