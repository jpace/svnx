#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/command'
require 'svnx/command/tc'

module Svnx::Cat
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "cat", cmdopts
    end
    
    def test_revision
      assert_command revision: 123
    end
  end
end
