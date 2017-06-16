#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx::Command
  class TestCase < Svnx::Common::TestCase
    def assert_command cmdcls, cmdopts, cls = Svnx::Base::MokkCommandLine
      cmd = cmdcls.new cmdopts, cls: cls
      cl = Svnx::Base::COMMAND_LINE_HISTORY[-1]
      assert_equal true, cl.executed, "cmdopts: #{cmdopts}"
      # assert_empty cmd.output, "cmdopts: #{cmdopts}"
    end
  end
end
