#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx::Command
  class TestCase < Svnx::TestCase
    def assert_command cmdcls, subcmd, cmdopts, cmdlinecls = Svnx::Base::MockCommandLine
      cmdcls.new cmdopts, cmdlinecls: cmdlinecls
      ex = cmdlinecls.all_executed.last
      assert_not_nil ex
      assert_equal ex.subcommand.to_s, subcmd.to_s
      assert ex.executed
      # assert_empty cmd.output, "cmdopts: #{cmdopts}"
    end
  end
end
