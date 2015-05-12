require_relative '../test_helper'

describe Project do
  before do
    setup_database
  end
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
end