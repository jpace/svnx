#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/diff/command'

Logue::Log.level = Logue::Log::DEBUG

class SvnDiffCmdLine
  class << self
    def executed
      @@executed
    end
    
    @@executed = false
  end
  
  def execute
    @@executed = true
    Array.new
  end
end

class SvnDiffCommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = SvnDiffCommand.new cmdopts
    info "cmd: #{cmd}"
    entries = cmd.entries
    assert_equal true, SvnDiffCmdLine.executed, "cmdopts: #{cmdopts}"
    assert_equal 0, entries.size, "cmdopts: #{cmdopts}"
  end
  
  def test_default
    assert_command
  end
  
  def test_commit
    assert_command commit: 123
  end
end
