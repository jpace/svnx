#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/command'
require 'svnx/command/tc'

module Svnx::Blame
  class CommandTest < Svnx::Command::TestCase
    def assert_command cmdopts = Hash.new
      super Command, "blame", cmdopts
    end
    
    def test_revision
      assert_command revision: 123, urls: %w{ /tmp/abc.txt }
    end
  end
end
