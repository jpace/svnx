#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/command'
require 'svnx/command/tc'

module Svnx::Commit
  COMMAND_LINE_HISTORY = Array.new
  
  class MokkCommandLine < Svnx::Base::MockCommandLine
    attr_reader :executed
    attr_reader :subcommand
    attr_reader :xml
    attr_reader :caching
    attr_reader :args    
    
    def execute
      @executed = true
      COMMAND_LINE_HISTORY << self
    end
  end
  
  class CommandTest < Svnx::Command::TestCase
    def assert_command exp, cmdopts = Hash.new
      cmd = Command.new cmdopts, cls: MokkCommandLine
      cl = COMMAND_LINE_HISTORY[-1]
      msg = "cmdopts: #{cmdopts}"
      assert_equal true,          cl.executed, msg
      assert_equal exp[:args],    cl.args,     msg
      assert_equal exp[:xml],     cl.xml,      msg
      assert_equal exp[:caching], cl.caching,  msg
    end
    
    def test_invalid_fields
      assert_raise do |e|
        assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
      end
      
      assert_raise do |e|
        assert_command url: "abc"
      end
    end
    
    def test_commit
      assert_command({ args: %w{ -F abc def ghi }, xml: false, caching: false }, file: "abc", paths: [ "def", "ghi" ])
    end
  end
end
