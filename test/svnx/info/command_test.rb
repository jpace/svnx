#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/command/tc'

class Svnx::Info::CommandTest < Svnx::Command::TestCase
  def assert_command cmdopts = Hash.new
    super Svnx::Info::Command, cmdopts
  end
  
  def test_revision
    assert_command revision: 123
  end
end
