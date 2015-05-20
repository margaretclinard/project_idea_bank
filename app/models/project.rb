class Project
  attr_reader :id, :errors
  attr_accessor :name, :description

  def initialize(name = nil)
    self.name = name
  end

  def self.all
    Database.execute("select * from projects order by name ASC").map do |row|
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
      Database.execute("INSERT INTO projects (name, description) VALUES (?,?)", name, description)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
      true
    else
      Database.execute("UPDATE projects SET name=?, description=? WHERE id=?", name, description, id)
      true
    end
  end

  def self.delete(id)
    Database.execute("DELETE FROM projects WHERE id=?", id)
  end

  private

  def self.populate_from_database(row)
    project = Project.new
    project.name = row['name']
    project.description = row['description']
    project.instance_variable_set(:@id, row['id'])
    project
  end
end