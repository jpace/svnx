#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/merge/command'

Logue::Log.level = Logue::Log::DEBUG

class SvnMergeCmdLine
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

class SvnMergeCommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = SvnMergeCommand.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, SvnMergeCmdLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_commit
    assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
  end
end
