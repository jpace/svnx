#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/propset/command'

Logue::Log.level = Logue::Log::DEBUG

class SvnPropsetCmdLine
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

class SvnPropsetCommandTest < Test::Unit::TestCase
  include Logue::Loggable

  def assert_command cmdopts = Hash.new
    cmd = SvnPropsetCommand.new cmdopts
    info "cmd: #{cmd}"
    assert_equal true, SvnPropsetCmdLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_revision
    assert_command revision: 123
  end
end
