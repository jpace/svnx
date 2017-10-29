#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/command/tc'

module Svnx::Info
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "info", cmdopts
    end
    
    def test_revision
      assert_command revision: 123
    end
  end
end
