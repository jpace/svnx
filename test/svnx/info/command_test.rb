#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/tc'

class Svnx::Info::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Info::Command.new cmdopts
    assert_equal true, Svnx::Base::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
    assert_nil cmd.entries, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
