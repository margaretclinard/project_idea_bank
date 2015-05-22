require 'highline/import'

class ProjectsController
  def index
    if Project.count > 0
      projects = Project.all # All of the projects in an array
      choose do |menu|
        puts MENU_FORMAT
        puts "All Projects".center(WIDTH)
        puts MENU_FORMAT
        menu.prompt = ""
        projects.each do |project|
          menu.choice(project.name) do
            loop do
              action_menu(project)
            end
          end
        end
        menu.choice("Exit") do
          say("Goodbye!")
          exit
        end
      end
    else
      say("No projects found. Add a project.\n")
    end
  end

  def edit_menu(project)
    loop do
      choose do |menu|
        menu.prompt = ""
        puts MENU_FORMAT
        puts "Edit \"#{project.name}\"".center(WIDTH)
        puts MENU_FORMAT

        menu.choice("Edit Name") do
          edit(project)
        end

        menu.choice("Edit Due Date") do
          edit_start(project)
        end

        menu.choice("Edit Description") do
          edit_description(project)
        end

        menu.choice("Edit Technology Stack") do
          edit_technology(project)
        end

        menu.choice("Back") do
          action_menu(project)
        end

        menu.choice("Exit") do
          say("Goodbye!")
          exit
        end
      end
    end
  end

  def action_menu(project)
    choose do |menu|
      puts MENU_FORMAT
      puts "Actions for \"#{project.name}\"".center(WIDTH)
      puts MENU_FORMAT
      menu.prompt = ""
      menu.choice("View Details") do
        say("\n**********************************************************************")
        say("#{project.name}".center(70) + "\n")
        say("**********************************************************************")

        start = Project.start(project.id)
        start.each do |date|
          start = date['start']
          say("\nDue Date: #{start}")
        end

        descriptions = Project.description(project.id)
        descriptions.each do |desc|
          description = desc['description']
          say("\nDescription: #{description}")
        end

        technologies = Project.technology(project.id)
        technologies.each do |tech|
          technology = tech['technology']
          say("\nTechnology Stack: #{technology}")
        end
        say("\n**********************************************************************")
      end

      menu.choice("Edit") do
        edit_menu(project)
      end

      menu.choice("Delete") do
        destroy(project.id)
      end

      projects_controller = ProjectsController.new
      menu.choice("All Projects") do
        projects_controller.index
        exit
      end

      menu.choice("Exit") do
        exit
      end
    end
  end

  def add(name, description, technology, start)
    project = Project.new
    project.name = name
    project.description = description
    project.technology = technology
    project.start = start
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
      user_input = ask("\nEnter a new name:")
      project.name = user_input.strip
      if project.save
        say("Project name has been updated to: \"#{project.name}\"")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_description(project)
    loop do
      user_input = ask("\nEnter a new description:")
      project.description = user_input.strip
      if project.save
        say("#{project.name}'s description has been updated to: \"#{project.description}\"")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_start(project)
    loop do
      user_input = ask("\nEnter a new start date:")
      project.start = user_input.strip
      if project.save
        say("#{project.name}'s start date has been updated to: \"#{project.start}\"")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_technology(project)
    loop do
      user_input = ask("\nEnter the complete technology stack:")
      project.technology = user_input.strip
      if project.save
        say("#{project.name}'s technology stack has been updated to: \"#{project.technology}\"")
        return
      else
        say(project.errors)
      end
    end
  end
end