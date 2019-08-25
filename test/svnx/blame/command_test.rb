#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/command'
require 'svnx/command/tc'

module Svnx::Blame
  class CommandTest < Svnx::Command::TestCase
    def test_revision
      args = { revision: 123, urls: %w[ /tmp/abc.txt ] }
      assert_command args
    end
  end
end
