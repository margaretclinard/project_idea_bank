require_relative '../test_helper'

describe Project do
  describe "#all" do
    describe "if there are no projects in the database" do
      it "should return an empty array" do
        assert_equal [], Project.all
      end
    end
    describe "if there are projects" do
      before do
        add_project("Project 1")
        add_project("Project 2")
        add_project("Project 3")
      end
      it "should return the projects in alphabetical order" do
        expected = ["Project 1", "Project 2", "Project 3"]
        actual = Project.all.map{ |project| project.name }
        assert_equal expected, actual
      end
    end
  end

  describe "#count" do
    describe "if there are no projects in the database" do
      it "should return 0" do
        assert_equal 0, Project.count
      end
    end
    describe "if there are projects" do
      before do
        add_project("Project 1")
        add_project("Project 2")
        add_project("Project 3")
      end
      it "should return the correct count" do
        assert_equal 3, Project.count
      end
    end
  end

  describe ".initialize" do
    it "sets the name attribute" do
      project = Project.new("foo")
      assert_equal "foo", project.name
    end
  end

  describe ".save" do
    describe "if the model is valid" do
      let(:project) { Project.new("Project 1") }
      it "should return true" do
        assert project.save
      end
      it "should save the model to the database" do
        project.save
        last_row = Database.execute("SELECT * FROM projects")[0]
        database_name = last_row['name']
        assert_equal "Project 1", database_name
      end
      it "should populate the model with the id from the database" do
        project.save
        last_row = Database.execute("SELECT * FROM projects")[0]
        database_id = last_row['id']
        assert_equal database_id, project.id
      end
    end

    describe "if the model is invalid" do
      let(:project){ Project.new("")}
      it "should return false" do
        refute project.save
      end
      it "should not save the model to the database" do
        project.save
        assert_equal 0, Project.count
      end
      it "should populate the error messages" do
        project.save
        assert_equal "\"\" is not a valid project name.", project.errors
      end
    end
  end

  describe ".valid?" do
    describe "with valid data" do
      let(:project) { Project.new("Project 1") }
      it "returns true" do
        assert project.valid?
      end
      it "should set errors to nil" do
        project.valid?
        assert project.errors.nil?
      end
    end

    describe "with no name" do
      let(:project) { Project.new(nil) }
      it "returns false" do
        refute project.valid?
      end
      it "sets the error message" do
        project.valid?
        assert_equal "\"\" is not a valid project name.", project.errors
      end
    end

    describe "with empty name" do
      let(:project) { Project.new("") }
      it "returns false" do
        refute project.valid?
      end
      it "sets the error message" do
        project.valid?
        assert_equal "\"\" is not a valid project name.", project.errors
      end
    end

    describe "with a name with no letter characters" do
      let(:project) { Project.new("777") }
      it "returns false" do
        refute project.valid?
      end
      it "sets the error message" do
        project.valid?
        assert_equal "\"777\" is not a valid project name.", project.errors
      end
    end

    describe "with a previously invalid name" do
      let(:project) { Project.new("666") }
      before do
        refute project.valid?
        project.name = "Project 1"
        assert_equal "Project 1", project.name
      end
      it "should return true" do
        assert project.valid?
      end
      it "should not have an error message" do
        project.valid?
        assert_nil project.errors
      end
    end
  end

end