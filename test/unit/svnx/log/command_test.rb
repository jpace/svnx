#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Log::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Log::Command.new cmdopts
    assert_equal true, Svnx::Base::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_log
    assert_command paths: "/tmp/svnx-from"
  end
end
