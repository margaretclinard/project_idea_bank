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

end