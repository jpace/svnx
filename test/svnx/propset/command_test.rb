#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/command'
require 'svnx/command/tc'

class Svnx::Propset::CommandTest < Svnx::Command::TestCase
  def assert_command cmdopts = Hash.new
    super Svnx::Propset::Command, cmdopts
  end
  
  def test_revision
    assert_command revision: 123
  end
end
