class Project
  attr_accessor :name

  def self.all
    Database.execute("select name from projects order by name ASC").map do |row|
      project = Project.new
      project.name = row[0]
      project
    end
  end

  def self.count
    Database.execute("select count(id) from projects")[0][0]
  end

  def self.create(name)
    return if /^\d+$/.match(name)
    if name.empty?
      raise ArgumentError.new
    else
      Database.execute("INSERT INTO projects (name) VALUES (?)", name)
    end
  end
end