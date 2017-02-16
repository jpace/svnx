#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/command'
require 'svnx/command/tc'

class Svnx::Cat::CommandTest < Svnx::Command::TestCase
  def assert_command cmdopts = Hash.new
    super Svnx::Cat::Command, cmdopts
  end
  
  def test_revision
    assert_command revision: 123
  end
end
