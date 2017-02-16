#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'

module Svnx
  module Command
  end
end

class Svnx::Command::TestCase < Svnx::Common::TestCase
  def assert_command cmdcls, cmdopts
    exec = Svnx::Base::MockCommandLine.new
    cmd = cmdcls.new cmdopts, exec: exec
    assert_equal true, exec.executed, "cmdopts: #{cmdopts}"
    assert_empty cmd.output, "cmdopts: #{cmdopts}"
  end
end
