require 'highline/import'

class ProjectsController
  def index
    if Project.count > 0
      projects = Project.all # All of the projects in an array
      choose do |menu|
        menu.prompt = ""
        projects.each do |project|
          menu.choice(project.name){ action_menu(project) }
        end
        menu.choice("Exit")
      end
    else
      say("No projects found. Add a project.\n")
    end
  end

  def action_menu(project)
    say("Would you like to?")
    choose do |menu|
      menu.prompt = ""
      menu.choice("View project details") do
        project = Project.find(project.id)
        say(project.name)
      end

      menu.choice("Edit") do
        edit(project)
      end
      menu.choice("Delete") do
        destroy(project)
      end
      menu.choice("Exit") do
        exit
      end
    end
  end

  def add(name)
    name_cleaned = name.strip
    project = Project.new(name_cleaned)
    if project.save
      "#{name} has been added."
    else
      project.errors
    end
  end
end