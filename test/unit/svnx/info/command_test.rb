#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/info/command'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Info::CommandLine
  class << self
    def executed
      @@executed
    end
    
    @@executed = false
  end
  
  def execute
    @@executed = true
    info "executed: #{@@executed}"
    Array.new
  end
end

class Svnx::Info::CommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Info::Command.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, Svnx::Info::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_nil cmd.entry, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
