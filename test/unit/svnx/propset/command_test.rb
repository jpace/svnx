#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/propset/command'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Propset::CommandLine
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

class Svnx::Propset::CommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = Svnx::Propset::Command.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, Svnx::Propset::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
