# project_idea_bank
NSS - Ruby Capstone Project - May 2015

## Project Vision

A command-line program that keeps track of project ideas and details.

Users will be able to add/edit/delete projects and their associated details.

## Features

### Adding a new project

To store specific project ideas, users can add projects to their idea bank.

Usage Example:

```
> ./idea_bank add [project name]
[project name]
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
* User passes in `add` command followed by a project name.
* The project name is printed with a prompt to enter the project's description and technology stack.
* Confirmation is printed showing the new project with details.

### Updating a project

In order to update the projects as specific details change, I want to edit projects.

Usage Example:

```
> ./idea_bank update [project name]
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
* User passes in `update` command followed by a project name.
* User is prompted to pick from the details that can be updated.
* User enters the corresponding update.
* The project update is printed along with a yes/no prompt for whether or not the update is complete.


### Deleting a project

In order to remove project ideas that I am no longer interested in pursuing, I want to delete existing projects.

Usage Example:

```
> ./idea_bank delete [project name]
[project name] has been deleted.
```

Acceptance Criteria:
* User inputs `delete` command followed by a project name.
* The project is deleted and a print out message confirms the deletion.

### Printing a list of all projects

In order to see a list of all the projects in my idea bank, the program should print a list of project names.

```
> ./idea_bank
My Projects
1. [project name]
2. [project name 2]
3. [project name 3]
> 1
[project name]
Details: This is an example user input of project description.
Stack: Ruby
Back? (y/n)
```

Acceptance Criteria:
* User executes `./idea_bank` with no argument.
* A list of projects is generated.
* User can select a project from the list to view/update/delete it.
