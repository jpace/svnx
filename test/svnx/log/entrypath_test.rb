#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/entry'
require 'svnx/tc'

module Svnx::Log
  class EntryPathTestCase < Svnx::TestCase
    def test
      ep = EntryPath.new kind: "file", action: Svnx::Action::ADDED, name: "abc"
      assert_equal "file", ep.kind
      assert_equal Svnx::Action::ADDED, ep.action
      assert_equal "abc", ep.name
    end
  end
end
