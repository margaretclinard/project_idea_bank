class Project
  attr_reader :id, :errors
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
    return false unless valid?
    Database.execute("INSERT INTO projects (name) VALUES (?)", name)
    @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
  end

  def valid?
    if name.nil? or name.empty? or /^\d+$/.match(name)
      @errors = "\"#{name}\" is not a valid project name."
      false
    else
      @errors = nil
      true
    end
  end
end