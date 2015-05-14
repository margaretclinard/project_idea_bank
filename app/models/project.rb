class Project
  attr_reader :id
  attr_accessor :name

  def initialize(name = nil)
    self.name = name
  end

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

  def save
    Database.execute("INSERT INTO projects (name) VALUES (?)", name)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  def self.create(name)
    return if /^\d+$/.match(name)
    if name.empty?
      raise ArgumentError.new
    else
    end
  end
end