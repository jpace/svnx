#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/diff/command'

Logue::Log.level = Logue::Log::DEBUG

class SvnDiffCmdLine
  def execute
    Array.new
  end
end

class CommandTest < Test::Unit::TestCase
  include Logue::Loggable
  
  def test_default
    cmd = SvnDiffCommand.new 
    info "cmd: #{cmd}"
  end
  
  def test_commit
    cmd = SvnDiffCommand.new commit: 123
    info "cmd: #{cmd}"
    entries = cmd.entries
    assert_equal 0, entries.diffs.size
  end
end
