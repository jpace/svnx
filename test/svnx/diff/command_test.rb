#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/command'
require 'svnx/command/tc'

module Svnx::Diff
  class CommandTest < Svnx::Command::TestCase
    def test_default
      assert_command
    end
    
    def test_change
      assert_command change: 123
    end
  end
end
