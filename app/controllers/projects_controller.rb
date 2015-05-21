require 'highline/import'

class ProjectsController
  def index
    if Project.count > 0
      projects = Project.all # All of the projects in an array
      choose do |menu|
        menu.prompt = ""
        projects.each do |project|
          menu.header = "\nProjects"
          menu.choice(project.name){ action_menu(project) }
        end
        menu.choice("Exit")
      end
    else
      say("No projects found. Add a project.\n")
    end
  end

  def action_menu(project)
    choose do |menu|
      menu.header = "\nProject Actions"
      menu.prompt = ""
      menu.choice("View project details") do
        descriptions = Project.description(project.id)
        descriptions.each do |desc|
          descriptions = desc['description']
          say("\nProject: #{project.name}")
          say("Details: #{descriptions}")
        end
      end

      menu.choice("Edit project name") do
        edit(project)
      end

      menu.choice("Edit project details") do
        edit_description(project)
      end

      menu.choice("Delete project") do
        destroy(project.id)
      end
      menu.choice("Exit") do
        exit
      end
    end
  end

  def add(name, description)
    project = Project.new
    project.name = name
    project.description = description
    if project.save
      "#{name} has been added.\n"
    else
      project.errors
    end
  end

  def destroy(id)
    Project.delete(id)
    say ("Project has been deleted.")
  end

  def edit(project)
    loop do
      user_input = ask("Enter a new name:")
      project.name = user_input.strip
      if project.save
        say("Project has been updated to: \"#{project.name}\"")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_description(project)
    loop do
      user_input = ask("Enter a new description:")
      project.description = user_input.strip
      if project.save
        say("Project description has been updated to: \"#{project.description}\"")
        return
      else
        say(project.errors)
      end
    end
  end
end