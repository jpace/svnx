#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/entries'
require 'svnx/status/xml'
require 'svnx/tc'

module Svnx::Status
  class EntriesTestCase < Svnx::TestCase
    def test_size
      entries = Entries.new XML::LINES
      assert_equal 5, entries.size
    end
  end
end
