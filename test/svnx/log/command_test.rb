#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/command'
require 'svnx/command/tc'

module Svnx::Log
  class CommandTest < Svnx::Command::TestCase
    def test_log
      args = { path: "/tmp/svnx-from" }
      assert_command args
    end
  end
end
