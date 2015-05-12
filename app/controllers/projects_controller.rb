class ProjectsController
  def index
    if Project.count > 0
      projects = Project.all # All of the projects in an array
      projects.each_with_index do |project, index|
        say("#{index + 1}. #{project.name}")
      end
    else
      say("No projects found. Add a project.\n")
    end
  end
end