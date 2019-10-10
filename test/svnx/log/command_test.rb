#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/command'
require 'svnx/command/tc'

module Svnx::Log
  class CommandTest < Svnx::Command::TestCase
    def test_log
      args = { path: "/tmp/svnx-from" }
      assert_command args
    end
    
    def test_xml
      cmd = Command.new Hash.new, cmdlinecls: Svnx::Base::MockCommandLine
      assert_equal true, cmd.xml?
    end
  end
end
