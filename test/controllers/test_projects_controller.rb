require_relative '../test_helper'

describe ProjectsController do

  describe ".index" do
    let(:controller) {ProjectsController.new}

    it "should say no projects found when empty" do
      skip
      actual_output = controller.index
      expected_output = "No projects found. Add a project.\n"
      assert_equal expected_output, actual_output
    end
  end

  describe ".add" do
    let(:controller) {ProjectsController.new}

    it "should add a project" do
      controller.add("Project 1", "This is a test description", "Start", "Tech")
      assert_equal 1, Project.count
    end
  end

end