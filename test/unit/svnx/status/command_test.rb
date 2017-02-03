#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Status::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Status::Command.new cmdopts
    assert_equal true, Svnx::Base::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_status
    assert_command paths: "/tmp/svnx-from"
  end
end
