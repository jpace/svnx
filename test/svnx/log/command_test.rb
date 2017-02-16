#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/command'
require 'svnx/command/tc'

class Svnx::Log::CommandTest < Svnx::Command::TestCase
  def assert_command cmdopts = Hash.new
    super Svnx::Log::Command, cmdopts
  end
  
  def test_log
    assert_command paths: "/tmp/svnx-from"
  end
end
