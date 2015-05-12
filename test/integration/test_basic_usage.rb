require_relative '../test_helper'

class TestBasicUsage < Minitest::Test

  def test_minimum_arguments_required
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank") do |pipe|
      expected_output = <<EOS
[Help] Run as: ./idea_bank manage
EOS
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

  def test_wrong_argument_given
    shell_output = ""
    expected_output = ""
    IO.popen("./idea_bank blah") do |pipe|
      expected_output = <<EOS
[Help] Run as: ./idea_bank manage
EOS
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end

end