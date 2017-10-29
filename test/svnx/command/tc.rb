#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx::Command
  class TestCase < Svnx::TestCase
    def assert_command cmdcls, subcmd, cmdopts, cls = Svnx::Base::MockCommandLine
      cmdcls.new cmdopts, cls: cls
      ex = Svnx::Base::MockCommandLine::latest_executed? subcmd
      assert_equal true, ex, "cmdopts: #{cmdopts}"
      # assert_empty cmd.output, "cmdopts: #{cmdopts}"
    end
  end
end
