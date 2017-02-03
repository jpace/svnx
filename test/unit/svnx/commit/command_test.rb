#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/command'
require 'svnx/tc'

Logue::Log.level = Logue::Log::DEBUG

class Svnx::Commit::CommandTest < Svnx::Common::TestCase
  add_execute_methods Svnx::Base::CommandLine
  
  def assert_command cmdopts = Hash.new
    cmd = Svnx::Commit::Command.new cmdopts
    assert_equal true, Svnx::Base::CommandLine.executed, "cmdopts: #{cmdopts}"    
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
  
  def test_commit
    assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
  end
end
