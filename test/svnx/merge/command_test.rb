#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/command'
require 'svnx/command/tc'

module Svnx::Merge
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "merge", cmdopts
    end
    
    def test_commit
      assert_command commit: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to"
    end
  end
end
