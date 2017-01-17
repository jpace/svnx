#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/status/command'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Status::CommandLine
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

class Svnx::Status::CommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Status::Command.new cmdopts
    assert_equal true, Svnx::Status::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_status
    assert_command paths: "/tmp/svnx-from"
  end
end
