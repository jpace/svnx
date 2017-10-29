#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/command'
require 'svnx/command/tc'

module Svnx::Status
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "status", cmdopts
    end
    
    def test_status
      assert_command paths: "/tmp/svnx-from"
    end
  end
end
