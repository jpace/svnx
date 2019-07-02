#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/add/command'
require 'svnx/command/tc'
require 'svnx/mock'

module Svnx::Add
  class CommandTest < Svnx::Command::TestCase
    def assert_command exp, cmdopts = Hash.new
      cmdlinecls = Svnx::Base::MockCommandLine
      Command.new cmdopts, cmdlinecls: cmdlinecls
      cl = cmdlinecls.all_executed.last
      msg = "cmdopts: #{cmdopts}"
      assert_equal true,          cl.executed, msg
      assert_equal exp[:args],    cl.args,     msg
      assert_equal exp[:xml],     cl.xml,      msg
      assert_equal exp[:caching], cl.caching,  msg
    end
    
    def test_invalid_fields
      assert_raise do |e|
        assert_command add: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
      end
      
      assert_raise do |e|
        assert_command url: "abc"
      end
    end
    
    def test_add
      exp = { args: %w{ abc def }, xml: false, caching: false }
      assert_command exp, paths: [ "abc", "def" ]
    end
  end
end
