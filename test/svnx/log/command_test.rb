#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/command'
require 'svnx/command/tc'

module Svnx::Log
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "log", cmdopts
    end
    
    def test_log
      assert_command paths: "/tmp/svnx-from"
    end
  end
end
