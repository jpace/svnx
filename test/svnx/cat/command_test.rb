#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/command'
require 'svnx/command/tc'

module Svnx::Cat
  class CommandTest < Svnx::Command::TestCase
    def test_revision
      args = { revision: 123 }
      assert_command args
    end
    
    def test_xml
      cmd = Command.new Hash.new, cmdlinecls: Svnx::Base::MockCommandLine
      assert_equal false, cmd.xml?
    end
  end
end
