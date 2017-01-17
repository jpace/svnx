#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/log/command'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Log::CommandLine
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

class Svnx::Log::CommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Log::Command.new cmdopts
    assert_equal true, Svnx::Log::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_log
    assert_command paths: "/tmp/svnx-from"
  end
end
