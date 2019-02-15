#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx::Command
  class TestCase < Svnx::TestCase
    def assert_command cmdcls, subcmd, cmdopts, cmdlinecls = command_line
      cmdcls.new cmdopts, cmdlinecls: cmdlinecls
      ex = cmdlinecls::latest_executed? subcmd
      assert_equal true, ex, "cmdopts: #{cmdopts}"
      # assert_empty cmd.output, "cmdopts: #{cmdopts}"
    end

    def command_line
      Svnx::Base::MockCommandLine
    end
  end
end
