require 'highline/import'

class ProjectsController
  def index
    if Project.count > 0
      projects = Project.all # All of the projects in an array
      projects_string = ""
      projects.each_with_index do |project, index|
        projects_string << "#{index + 1}. #{project.name}\n"
      end
      projects_string
    else
      "No projects found. Add a project.\n"
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