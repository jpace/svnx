#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/commit/command'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Commit::CommandLine
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

class Svnx::Commit::CommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Commit::Command.new cmdopts
    assert_equal true, Svnx::Commit::CommandLine.executed, "cmdopts: #{cmdopts}"    
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_commit
    assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
  end
end
