#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Diff::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Diff::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Diff::Command.new cmdopts
    entries = cmd.entries
    assert_equal true, Svnx::Diff::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_equal 0, entries.size, "cmdopts: #{cmdopts}"
  end
  
  def test_default
    assert_command
  end
  
  def test_commit
    assert_command commit: 123
  end
end
