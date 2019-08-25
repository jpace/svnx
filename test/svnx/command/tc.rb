#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx::Command
  class TestCase < Svnx::TestCase
    def command_line_class
      Svnx::Base::MockCommandLine
    end

    def command_class
      re = Regexp.new '^(.*)::\w+$'
      modname = self.class.name.sub re, '\1'
      mod = Kernel.const_get modname
      mod::Command
    end

    def subcommand
      re = Regexp.new '^\w+::(\w+)::.*'
      name = self.class.name.sub re, '\1'
      name.downcase
    end

    def assert_command cmdopts = Hash.new
      cmdlinecls = Svnx::Base::MockCommandLine
      command_class.new cmdopts, cmdlinecls: cmdlinecls
      ex = cmdlinecls.all_executed.last
      assert_not_nil ex
      assert_equal ex.subcommand.to_s, subcommand
      assert ex.executed
    end
  end
end
