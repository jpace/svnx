#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/command'
require 'svnx/tc'

class Svnx::Merge::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Merge::Command.new cmdopts
    assert_equal true, Svnx::Base::CommandLine.executed, "cmdopts: #{cmdopts}"    
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_commit
    assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
  end
end
