#!/usr/bin/ruby -w
# -*- ruby -*-

require 'cmdline/line'
require 'svnx/tc'
require 'paramesan'

Logue::Log.level = Logue::Log::WARN

class CmdLine::CommandLineTestCase < Svnx::TestCase
  include Paramesan
  
  # init

  def assert_init expected, initargs
    cl = CmdLine::CommandLine.new initargs
    assert_equal expected, cl.args
  end
    
  def test_init
    assert_init [ "ls" ], [ "ls" ]
  end

  # <<

  def assert_lshift expected, initargs, add
    cl = CmdLine::CommandLine.new initargs
    cl << add
    assert_equal expected, cl.args
  end

  def test_lshift
    assert_lshift [ "ls", "/tmp" ], [ "ls" ], "/tmp"
  end

  # to_command

  def assert_to_command expected, args
    cl = CmdLine::CommandLine.new args
    assert_equal expected, cl.to_command
  end

  def test_to_command_init
    assert_to_command "ls", [ "ls" ]
  end

  # execute/status

  def assert_execute expected, args
    cl = CmdLine::CommandLine.new args
    cl.execute
    assert_equal expected, cl.status.success?, "args: #{args}"
  end

  param_test [
    [ true,  [ "ls", "/tmp" ] ],
    [ false, [ "ls", "/doesntexist" ] ]
  ] do |exp, args|
    assert_execute exp, args
  end
end
