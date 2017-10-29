#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/update/command'
require 'svnx/command/tc'

module Svnx::Update
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "update", cmdopts
    end
    
    def test_update
      assert_command paths: "/tmp/svnx-from"
    end
  end
end
