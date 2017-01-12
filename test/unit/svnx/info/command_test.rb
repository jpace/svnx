#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/info/command'

Logue::Log.level = Logue::Log::DEBUG

class SvnInfoCmdLine
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

class SvnInfoCommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = SvnInfoCommand.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, SvnInfoCmdLine.executed, "cmdopts: #{cmdopts}"
    assert_nil cmd.entry, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
