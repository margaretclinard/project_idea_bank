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

        menu.choice('Main Menu') do
          ProjectsController.manage_menu
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

  def self.manage_menu
    loop do
      choose do |menu|
        puts MENU_FORMAT
        puts "Project Tracker: Main Menu".center(WIDTH)
        puts MENU_FORMAT
        menu.prompt = ""

        projects_controller = ProjectsController.new
        menu.choice('All Projects') do
          projects_controller.index
          exit
        end

        menu.choice('Add New Project') do
          puts MENU_FORMAT
          puts "New Project Creation".center(WIDTH)
          puts MENU_FORMAT
          user_input_project = ask("Enter project name.")

          user_input_start = ask("\nEnter a due date.")

          user_input_desc = ask("\nEnter a brief description of the project.")

          user_input_technology = ask("\nEnter the technologies you intend to use.")
          response = projects_controller.add(user_input_project, user_input_desc, user_input_technology, user_input_start)
          say("\n#{user_input_project} has been saved:\nDescription: #{user_input_desc}\nStack: #{user_input_technology}\nDue Date: #{user_input_start}") unless response.nil?
        end

        menu.choice('Exit') do
          say("Goodbye!")
          exit
        end
      end
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
    puts "\n**********************************************************************"
    puts "PROJECT DETAILS: #{project.name}".center(70) + "\n"
    puts "**********************************************************************"

    start = Project.start(project.id)
    start.each do |date|
      start = date['start']
      puts "\nDue Date: #{start}"
    end

    descriptions = Project.description(project.id)
    descriptions.each do |desc|
      description = desc['description']
      puts "\nDescription: #{description}"
    end

    technologies = Project.technology(project.id)
    technologies.each do |tech|
      technology = tech['technology']
      puts "\nTechnology Stack: #{technology}"
    end

    choose do |menu|
      puts MENU_FORMAT
      puts "Actions for \"#{project.name}\"".center(WIDTH)
      puts MENU_FORMAT
      menu.prompt = ""

      menu.choice("Edit") do
        edit_menu(project)
      end

      menu.choice("Delete") do
        puts MENU_FORMAT
        puts "Delete \"#{project.name}\"".center(WIDTH)
        puts MENU_FORMAT
        response = ask("Are you sure you want to delete \"#{project.name}\"? y/n")
        if response == "y" or response == "yes"
          destroy(project.id)
        elsif response == "n" or response == "no"
          puts "* \"#{project.name}\" has NOT been deleted. *"
          action_menu(project)
        else
          puts "* Invalid input. Project has NOT been deleted. Try again with y/n. *"
        end
      end

      menu.choice("Main Menu") do
        ProjectsController.manage_menu
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
    say ("* Project has been deleted. *")
    index
  end

  def edit(project)
    loop do
      say("Current name: #{project.name}")
      user_input = ask("\nEnter a new name:")
      project.name = user_input.strip
      if project.save
        say("* Project name has been updated to: \"#{project.name}\". *")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_description(project)
    loop do
      say("Current description: #{project.description}")
      user_input = ask("\nEnter a new description:")
      project.description = user_input.strip
      if project.save
        say("* #{project.name}'s description has been updated to: \"#{project.description}\". *")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_start(project)
    loop do
      say("Current due date: #{project.start}")
      user_input = ask("\nEnter a new due date:")
      project.start = user_input.strip
      if project.save
        say("* #{project.name}'s due date has been updated to: \"#{project.start}\". *")
        return
      else
        say(project.errors)
      end
    end
  end

  def edit_technology(project)
    loop do
      say("Current stack: #{project.technology}")
      user_input = ask("\nEnter the complete technology stack:")
      project.technology = user_input.strip
      if project.save
        say("* #{project.name}'s technology stack has been updated to: \"#{project.technology}\". *")
        return
      else
        say(project.errors)
      end
    end
  end
end