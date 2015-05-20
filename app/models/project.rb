class Project
  attr_reader :id, :errors
  attr_accessor :name, :description

  def initialize(name = nil)
    self.name = name
    @id
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

  def save
    return false unless valid?
    if @id.nil?
      Database.execute("INSERT INTO projects (name) VALUES (?)", name)
      @id = Database.execute("SELECT last_insert_rowid()")[0]['last_insert_rowid()']
    else
      Database.execute("UPDATE projects SET name=? WHERE id=?", name, id)
      true
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

  private

  def self.populate_from_database(row)
    project = Project.new
    project.name = row['name']
    project.instance_variable_set(:@id, row['id'])
    project
  end
end