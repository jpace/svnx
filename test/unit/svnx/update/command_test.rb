#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Update::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Update::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Update::Command.new cmdopts
    assert_equal true, Svnx::Update::CommandLine.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_update
    assert_command paths: "/tmp/svnx-from"
  end
end
