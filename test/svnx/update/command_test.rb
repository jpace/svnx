#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/command'
require 'svnx/command/tc'

class Svnx::Update::CommandTest < Svnx::Command::TestCase
  def assert_command cmdopts = Hash.new
    super Svnx::Update::Command, cmdopts
  end
  
  def test_update
    assert_command paths: "/tmp/svnx-from"
  end
end
