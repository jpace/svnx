#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/command'
require 'svnx/command/tc'

module Svnx::Status
  class CommandTest < Svnx::Command::TestCase
    def test_status
      args = { paths: "/tmp/svnx-from" }
      assert_command args
    end
  end
end
