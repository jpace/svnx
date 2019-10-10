#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/command'
require 'svnx/command/tc'
require 'svnx/mock'

module Svnx::Commit
  class CommandTest < Svnx::Command::TestCase
    def assert_command exp, cmdopts = Hash.new
      cmdlinecls = Svnx::Base::MockCommandLine
      Command.new cmdopts, cmdlinecls: cmdlinecls
      cl = cmdlinecls.all_executed.last
      
      assert_equal true,          cl.executed
      assert_equal exp[:args],    cl.args
      assert_equal exp[:caching], cl.caching
    end
    
    def test_invalid_fields
      assert_raise do |e|
        args = { commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to" }
        assert_command args
      end
      
      assert_raise do |e|
        args = { url: "abc" }
        assert_command args
      end
    end
    
    def test_commit
      exp = { args: %w{ --file abc def ghi }, caching: false }
      assert_command exp, file: "abc", paths: [ "def", "ghi" ]
    end
    
    def test_xml
      cmd = Command.new Hash.new, cmdlinecls: Svnx::Base::MockCommandLine
      assert_equal false, cmd.xml?
    end
  end
end
