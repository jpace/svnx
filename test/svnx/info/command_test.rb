#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/command'
require 'svnx/command/tc'

module Svnx::Info
  class CommandTest < Svnx::Command::TestCase
    def test_revision
      args = { revision: 123 }
      assert_command args
    end
  end
end
