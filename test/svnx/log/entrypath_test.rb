#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/tc'
require 'svnx/log/entry'

module Svnx::Log
  class EntryPathTestCase < Svnx::Log::TestCase
    def test
      ep = EntryPath.new kind: "file", action: Svnx::Action::ADDED, name: "abc"
      assert_equal "file", ep.kind
      assert_equal Svnx::Action::ADDED, ep.action
      assert_equal "abc", ep.name
    end
  end
end
