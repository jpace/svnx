#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/command'
require 'svnx/command/tc'

module Svnx::Diff
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "diff", cmdopts
    end
    
    def test_default
      assert_command
    end
    
    def test_commit
      assert_command commit: 123
    end
  end
end
