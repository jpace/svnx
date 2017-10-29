#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/command'
require 'svnx/command/tc'

module Svnx::Propset
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "propset", cmdopts
    end
    
    def test_revision
      assert_command revision: 123
    end
  end
end
