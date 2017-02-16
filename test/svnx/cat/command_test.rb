#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/command'
require 'svnx/tc'

class Svnx::Cat::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Cat::Command.new cmdopts
    assert_equal true, Svnx::Base::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
