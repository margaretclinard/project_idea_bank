class Project
  attr_reader :id, :errors
  attr_accessor :name, :description, :technology, :start

  def initialize(name = nil)
    self.name = name
  end

  def self.all
    Database.execute("select * from projects order by start ASC").map do |row|
      populate_from_database(row)
    end
  end

  def self.count
    Database.execute("select count(id) from projects")[0][0]
  end

  def self.find(id)
    row = Database.execute("select * from projects where id = ?", id).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
  end

  def self.find_by_name(name)
    row = Database.execute("select * from projects where name LIKE ?", name).first
    if row.nil?
      nil
    else
      populate_from_database(row)
    end
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

  def save
    return false unless valid?
    if @id.nil?
      Database.execute("INSERT INTO projects (name, description, technology, start) VALUES (?,?,?,?)", name, description, technology, start)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      true
    else
      Database.execute("UPDATE projects SET name=?, description=?, technology=?, start=? WHERE id=?", name, description, technology, start, id)
      true
    end
  end

  def self.delete(id)
    Database.execute("DELETE FROM projects WHERE id=?", id)
  end

  def self.description(id)
    Database.execute("SELECT description FROM projects where id =?", id)
  end

  def self.technology(id)
    Database.execute("SELECT technology FROM projects where id =?", id)
  end

  def self.start(id)
    Database.execute("SELECT start FROM projects where id =?", id)
  end

  private

  def self.populate_from_database(row)
    project = Project.new
    project.name = row['name']
    project.description = row['description']
    project.start = row['start']
    project.technology = row['technology']
    project.instance_variable_set(:@id, row['id'])
    project
  end
end