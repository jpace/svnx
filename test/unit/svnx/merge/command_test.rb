#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/merge/command'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Merge::CmdLine
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

class Svnx::Merge::CommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Merge::Command.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, Svnx::Merge::CmdLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_commit
    assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
  end
end
