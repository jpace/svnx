#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/command'
require 'svnx/command/tc'

class Svnx::Status::CommandTest < Svnx::Command::TestCase
  def assert_command cmdopts = Hash.new
    super Svnx::Status::Command, cmdopts
  end
  
  def test_status
    assert_command paths: "/tmp/svnx-from"
  end
end
