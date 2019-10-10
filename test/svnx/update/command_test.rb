#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/command'
require 'svnx/command/tc'

module Svnx::Update
  class CommandTest < Svnx::Command::TestCase
    def test_update
      args = { paths: "/tmp/svnx-from" }
      assert_command args
    end

    def test_xml
      cmd = Command.new Hash.new, cmdlinecls: Svnx::Base::MockCommandLine
      assert_equal false, cmd.xml?
    end
  end
end
