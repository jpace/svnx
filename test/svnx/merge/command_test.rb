#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/command'
require 'svnx/command/tc'

module Svnx::Merge
  class CommandTest < Svnx::Command::TestCase
    def test_change
      args = { change: 123, from: "/tmp/svnx-from", to: "/tmp/svnx-to" }
      assert_command args
    end
  end
end
