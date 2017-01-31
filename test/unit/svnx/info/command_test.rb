#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Info::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Info::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Info::Command.new cmdopts
    assert_equal true, Svnx::Info::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
    assert_nil cmd.entries, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
